//
//  APIManager.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/28.
//

import Foundation
import RxCocoa
import RxSwift

fileprivate extension Encodable {
    var dictionaryValue: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return nil }
        return dictionary
    }
}

class APIMangger {
    static let enviroment: Environment = .dev

    private static var _shared = APIMangger()
    private lazy var apiRequest = APIRequest(config: .default)
    public let imageCache = NSCache<NSURL, UIImage>()
    
    class func shared() -> APIMangger {
        return _shared
    }
    
    func getCharacters(name: String = "", species: String = "", gender: String = "") throws -> Observable<[Character]> {
        let type = RequestType.getCharacters(name, species: species, gender: gender)
        var request = URLRequest(url: type.url)
        request.httpMethod = type.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return apiRequest.callRequest(request: request).map {(data: RMCharacterResponse) in
            return data.getData()
        }
    }
    
    func getSingleEpisode(_ id: Int) throws -> Observable<RMEpisodeResponse> {
        let type = RequestType.getSingleEpisode(id)
        var request = URLRequest(url: type.url)
        request.httpMethod = type.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return apiRequest.callRequest(request: request).map{(data: RMEpisodeResponse) in
            return data
        }
    }
    
    func downloadImage(_ imagePath: String) throws -> Observable<UIImage?> {
        let type = RequestType.downloadImage(imagePath)
        if let image = imageCache.object(forKey: type.url as NSURL) {
            return Observable<UIImage?>.create({ observer -> Disposable in
                observer.onNext(image)
                observer.onCompleted()
                return Disposables.create()
            })
        }else {
            var request = URLRequest(url: type.url)
            request.httpMethod = type.method.rawValue
            return apiRequest.callRequestData(request: request).map{(data: Data?) in
                guard let data = data else { return nil }
                return UIImage(data: data, scale: 1)
            }
        }
    }
    
}
