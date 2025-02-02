//
//  RMCharacterViewModel.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/30.
//

import Foundation
import UIKit.UIImage
import RxSwift
import RxCocoa

class CharacterListViewModel: ViewModel {
    
    // MARK: Inputs
    let input: Input
    
    struct Input {
        let viewDidRefresh: AnyObserver<Void>
        let searchName: AnyObserver<String>
        let speciesRelay: BehaviorRelay<String>
        let genderRelay: BehaviorRelay<String>
    }
    
    // MARK: Outputs
    let output: Output
    
    struct Output {
        let characters: Driver<[Character]>
        let otherCharacters: Driver<[Character]>
        let isLoading: Driver<Bool>
        let error: Driver<Error>
    }
    
    // MARK: Private properties
    private let viewDidRefreshSubject = PublishSubject<Void>()
    private let searchNameSubject = BehaviorSubject<String>(value: "")
    private let charactersSubject = PublishSubject<[Character]>()
    private let speciesRelay = BehaviorRelay<String>(value: "")
    private let genderRelay = BehaviorRelay<String>(value: "")
    private let isLoadingSubject = PublishSubject<Bool>()
    private let errorSubject = PublishSubject<Error>()
    
    // MARK: Initialisation
    
    deinit {
        print("DEBUG: CharacterListViewModel deinit")
    }
    
    init() {
        let errorRelay = PublishRelay<ErrorType>()
        input = Input(viewDidRefresh: viewDidRefreshSubject.asObserver(),
                      searchName: searchNameSubject.asObserver(),
                      speciesRelay: speciesRelay,
                      genderRelay: genderRelay)
        
        
        let filterParameters = Observable.combineLatest(searchNameSubject, speciesRelay, genderRelay)
            .distinctUntilChanged { (old, new) in
                return old == new
            }
        
        let characters = Observable
            .merge(viewDidRefreshSubject.withLatestFrom(filterParameters), filterParameters)
            .debug("viewDidRefreshSubject")
            .startLoading(loadingSubject: isLoadingSubject)
            .flatMapLatest {name, species, gender in
                try APIMangger.shared().getCharacters(name: name, species: species, gender: gender)
            }.catch { error in
                print("DEBUG: error: \(error)")
                errorRelay.accept(error as! ErrorType)
                return Observable.just([])
            }
            .stopLoading(loadingSubject: isLoadingSubject)
            .share(replay: 1, scope: .whileConnected)
        
        let partCharacters = characters.map { items in
            items.reduce(into: (human: [Character](), other: [Character]())) { result, character in
                if character.species == .human {
                    result.human.append(character)
                }else {
                    result.other.append(character)
                }
            }
        }
        
        output = Output(characters: partCharacters.map { $0.human }.asDriver(onErrorJustReturn: []),
                        otherCharacters: partCharacters.map { $0.other }.asDriver(onErrorJustReturn: []),
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        error: errorSubject.asDriver(onErrorJustReturn: ErrorType.ERROR_INVAILD_OTHER_FAILLURE))
    }
    
}

