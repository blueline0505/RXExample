//
//  Observable+Extention.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/1/3.
//

import Foundation
import RxSwift

extension Observable where Element: Any {
    func startLoading(loadingSubject: PublishSubject<Bool>) -> Observable<Element> {
        return self.do(onNext: {_ in
            loadingSubject.onNext(true)
        })
    }
    
    func stopLoading(loadingSubject: PublishSubject<Bool>) -> Observable<Element> {
        return self.do(onNext: {_ in
            loadingSubject.onNext(false)
        })
    }
    
//    func catchErrorCode(errorType: Observable<ErrorType>? = nil) -> Observable<Element> {
//        return self.do(onNext: { result in
//            
//        })
//    }
    
    func catchErrorCode(completion: @escaping ((ErrorType)-> Void)) -> Observable<Element> {
        return flatMap { result in
            
            guard let response = result as? HTTPURLResponse else {
                completion(ErrorType.ERROR_INVAILD_DECODE_FAILURE)
                return Observable.just(result)
            }
            
            if response.statusCode != 200 {
                completion(ErrorType.ERROR_INVAILD_DECODE_FAILURE)
            }
            
            return Observable.just(result)
        }
    }
}

//extension ObservableType where Element: HTTPURLResponse {
//    func catchErrorCode(completion: @escaping ((ErrorType)-> Void)) -> Observable<Element> {
//        return flatMap { response in
//            
//            if response.statusCode != 200 {
//                completion(ErrorType.ERROR_INVAILD_DECODE_FAILURE)
//            }
//            
//            return Observable.just(response)
//        }
//    }
//    
//}
//
//extension PrimitiveSequence where Trait == SingleTrait, Element: Sequence {
//    
//    func catchAPIError(errorType: Observable<ErrorType>? = nil) -> Single<Element> {
//        return flatMap { response in
//            
//        
//            
//            
//            return .just(response)
//        }
//    }
//    
//}
