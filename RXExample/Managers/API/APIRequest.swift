//
//  APIRequest.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/28.
//

import Foundation
import RxSwift
import RxCocoa

class APIRequest {
    private lazy var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession
    
    public init(config: URLSessionConfiguration) {
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func callRequest<T: Decodable>(request: URLRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let task = self.urlSession.dataTask(with: request) {(data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return observer.onError(ErrorType.ERROR_REQUEST_FAILED)
                }
                
                let statusCode = httpResponse.statusCode
                guard (200...399).contains(statusCode) else {
                    print("DEBUG: statusCode: \(statusCode)")
                    observer.onError(ErrorType.ERROR_BAD_STATUS_CODE)
                    return
                }
                do {
                    let resultData: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(resultData)
                }catch let error {
                    print("DEBUG: error \(error)")
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    public func callRequestData(request: URLRequest) -> Observable<Data?> {
        return Observable<Data?>.create { observer in
            let task = self.urlSession.dataTask(with: request) {(data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return observer.onError(ErrorType.ERROR_REQUEST_FAILED)
                }
                let statusCode = httpResponse.statusCode
                guard (200...399).contains(statusCode) else {
                    observer.onError(ErrorType.ERROR_BAD_STATUS_CODE)
                    return
                }
                observer.onNext(data)
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
