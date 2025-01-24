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
    }
    
    private let viewDidRefreshSubject = PublishSubject<Void>()
    
    // MARK: Outputs
    let output: Output
    
    struct Output {
        let aliveCharacters: Driver<[Character]>
        let otherCharacters: Driver<[Character]>
        let isLoading: Driver<Bool>
        let error: Driver<Error>
    }
    
    private let isLoadingSubject = PublishSubject<Bool>()
    private let errorSubject = PublishSubject<Error>()
    
    // MARK: Private properties
    private let charactersSubject = PublishSubject<[Character]>()
    
    
    // MARK: Initialisation
    init() {
        let errorRelay = PublishRelay<ErrorType>()
        input = Input(viewDidRefresh: viewDidRefreshSubject.asObserver())
        
        
        //load api data
        let characters = viewDidRefreshSubject
            .asObservable()
            .startLoading(loadingSubject: isLoadingSubject)
            .flatMapLatest({ try APIMangger.shared().getCharacters()})
            .catchErrorCode(completion: { errorType in
                print("DEBUG: errorType: \(errorType)")
            })
            .stopLoading(loadingSubject: isLoadingSubject)
            .asDriver {(error) -> Driver<[Character]> in
                errorRelay.accept((error as? ErrorType) ?? ErrorType.ERROR_INVAILD_OTHER_FAILLURE )
                return Driver.just([])
            }
        
        let partCharacters = characters.map { items in
            items.reduce(into: (alive: [Character](), other: [Character]())) { result, character in
                if character.status == .Alive {
                    result.alive.append(character)
                }else {
                    result.other.append(character)
                }
            }
        }
        
        output = Output(aliveCharacters: partCharacters.map { $0.alive },
                        otherCharacters: partCharacters.map { $0.other },
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        error: errorSubject.asDriver(onErrorJustReturn: ErrorType.ERROR_INVAILD_OTHER_FAILLURE))
    }
    
}

