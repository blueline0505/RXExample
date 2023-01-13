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
}
