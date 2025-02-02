//
//  RMCharacterResponse.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/30.
//

import Foundation

struct RMCharacterResponse: Decodable {
    let data: [RMCharacter]
}

struct RMCharacter: Decodable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: RMCharacterSpecie
    let type: String
    let gender: RMCharacterGender
    let origin: RMCharacterOrigin
    let location: RMCharacterLocation
    let imagePath: String
    let episode: [String]
    let url: String
    let created: Date
}

struct RMCharacterOrigin: Decodable {
    let name: String
    let url: String
}

struct RMCharacterLocation: Decodable {
    let name: String
    let url: String
}

enum RMCharacterStatus: String, Decodable, CaseIterable {
    case Alive = "Alive"
    case Dead = "Dead"
    case Unknown = "unknown"
}

enum RMCharacterGender: String, Decodable, CaseIterable {
    case Female = "Female"
    case Male = "Male"
    case Genderless = "Genderless"
    case Unknown = "unknown"
}

enum RMCharacterSpecie: String, Decodable, CaseIterable {
    case human = "Human"
    case alien = "Alien"
    case animal = "Animal"
    case humanoid = "Humanoid"
    case unknown = "unknown"
}

// MARK: - CodingKeys
extension RMCharacterOrigin {
    enum CodingKeys: CodingKey {
        case name
        case url
    }
}

extension RMCharacterLocation {
    enum CodingKeys: CodingKey {
        case name
        case url
    }
}

extension RMCharacter {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case imagePath = "image"
        case episode
        case url
        case created
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(RMCharacterStatus.self, forKey: .status)
        
        do {
            self.species = try container.decode(RMCharacterSpecie.self, forKey: .species)
        }catch let error {
            print("created species error:\(error.localizedDescription)")
            self.species = .unknown
        }
        
        self.type = try container.decode(String.self, forKey: .type)
        self.gender = try container.decode(RMCharacterGender.self, forKey: .gender)
        self.origin = try container.decode(RMCharacterOrigin.self, forKey: .origin)
        self.location = try container.decode(RMCharacterLocation.self, forKey: .location)
        self.imagePath = try container.decode(String.self, forKey: .imagePath)
        self.episode = try container.decode([String].self, forKey: .episode)
        self.url = try container.decode(String.self, forKey: .url)
        
        do {
            let dateStr = try container.decode(String.self, forKey: .created)
            let dateFormatter = ISO8601DateFormatter()
            let date = dateFormatter.date(from: dateStr)
            self.created = date ?? Date()
        }catch let error {
            print("created error:\(error.localizedDescription)")
            self.created = Date()
        }
    }
}

extension RMCharacterResponse {
    enum CodingKeys: String, CodingKey {
        case data = "results"
    }
}

// MARK: - Helper methods
extension RMCharacterResponse {
    func getData() -> [Character] {
        return self.data.map({ Character(id: $0.id,
                                         name: $0.name,
                                         status: $0.status,
                                         species: $0.species,
                                         type: $0.type,
                                         gender: $0.gender,
                                         origin: $0.origin,
                                         location: $0.location,
                                         imagePath: $0.imagePath,
                                         episode: $0.episode,
                                         url: $0.url,
                                         created: $0.created)})
    }
}
