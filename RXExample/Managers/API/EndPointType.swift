//
//  EndPointType.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/28.
//

import Foundation

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var method: ReqestMethod { get }
    var url: URL { get }
}

enum ReqestMethod: String {
    case Get
    case Post
    case Put
    case Delete
}

enum Environment {
    case dev
    case prod
}

enum RequestType {
    case getCharacters(_ name: String, species: String, gender: String)
    case getLocations
    case getEpisodes
    case getSingleEpisode(_ id: Int)
    case downloadImage(_ imagePath: String)
}

extension RequestType: EndPointType {
    var baseURL: String {
        switch APIMangger.enviroment {
        case .dev: return "https://rickandmortyapi.com/api/"
        case .prod: return "https://rickandmortyapi.com/api/"
        }
    }
    
    var path: String {
        switch self {
        case .getCharacters: return "character"
        case .getLocations: return "location"
        case .getEpisodes: return "episodes"
        case .getSingleEpisode(let id): return "episode/\(id)"
        case .downloadImage(let imagePath): return imagePath
        }
    }

    var method: ReqestMethod {
        switch self {
        default: return .Get
        }
    }
    
    var url: URL {
        switch self {
        case .getCharacters(let name, let species, let gender):
            
            var components = URLComponents(string: self.baseURL + self.path)!
    
            var queryItems: [URLQueryItem] = []
            if !name.isEmpty {
                queryItems.append(URLQueryItem(name: "name", value: name))
            }
            
            if !species.isEmpty {
                queryItems.append(URLQueryItem(name: "species", value: species))
            }
            
            if !gender.isEmpty {
                queryItems.append(URLQueryItem(name: "gender", value: gender))
            }
            
            components.queryItems = queryItems
            return components.url!
        case .downloadImage(let imagePath): return URL(string: imagePath)!
        default: return URL(string: self.baseURL + self.path)!
        }
    }
}
