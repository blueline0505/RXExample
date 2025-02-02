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
    
    func catchErrorCode(completion: @escaping ((ErrorType)-> Void)) -> Observable<Element> {
        return flatMap { result in
            
            if let response = result as? HTTPURLResponse, response.statusCode != 200 {
                completion(ErrorType.ERROR_INVAILD_DECODE_FAILURE)
            }
            
            return Observable.just(result)
        }
    }
}

