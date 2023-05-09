//
//  RMCharacterEpsoCollectionViewModel.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/5/4.
//

import Foundation
import RxSwift
import RxCocoa

class RMCharacterEpisodeCollectionViewModel: ViewModel {
    // MARK: Input
    let input: Input
    
    struct Input {
        let pathObserver: AnyObserver<String>
    }
    
    private let pathSubjcet = PublishSubject<String>()
    
    // MARK: Output
    let output: Output
    
    struct Output {
//        let
    }
    
    init() {
        input = Input(pathObserver: pathSubjcet.asObserver())
        
//        let characters = viewDidRefreshSubject
//            .asObservable()
//            .startLoading(loadingSubject: isLoadingSubject)
//            .flatMapLatest({ try APIMangger.shared().getCharacters()})
//            .stopLoading(loadingSubject: isLoadingSubject)
//            .asDriver {(error) -> Driver<[Character]> in
//                errorRelay.accept((error as? ErrorType) ?? ErrorType.ERROR_INVAILD_OTHER_FAILLURE )
//                return Driver.just([])
//            }
        
        let responseSubject = pathSubjcet
            .flatMap({ try APIMangger.shared().})
        
        output = Output(characters: characters,
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        error: errorSubject.asDriver(onErrorJustReturn: ErrorType.ERROR_INVAILD_OTHER_FAILLURE))
        
        output = Output()
    }
    
}
