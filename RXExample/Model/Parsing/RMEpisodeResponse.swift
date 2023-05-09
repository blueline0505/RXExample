//
//  RMEpisodeResponse.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/5/4.
//

import Foundation

struct RMEpisodeResponse: Decodable {
    let id: Int
    let name: String
    let airDate: Date
    let episode: String
    let characterPath: [String]
    let url: String
    let created: Date
}

extension RMEpisodeResponse {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characterPath = "characters"
        case url
        case created
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        do {
            let dateStr = try container.decode(String.self, forKey: .airDate)
            let dateFormatter = ISO8601DateFormatter()
            let date = dateFormatter.date(from: dateStr)
            self.airDate = date ?? Date()
        }catch let error {
            print("airDate error:\(error.localizedDescription)")
            self.airDate = Date()
        }
        self.episode = try container.decode(String.self, forKey: .episode)
        self.characterPath = try container.decode([String].self, forKey: .characterPath)
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


// MARK: - Helper methods
extension RMEpisodeResponse { // TODO: convert Episode
//    func getData() -> [Character] {
//        return self.data.map({ Character(id: $0.id,
//                                         name: $0.name,
//                                         status: $0.status,
//                                         species: $0.species,
//                                         type: $0.type,
//                                         gender: $0.gender,
//                                         origin: $0.origin,
//                                         location: $0.location,
//                                         imagePath: $0.imagePath,
//                                         episode: $0.episode,
//                                         url: $0.url,
//                                         created: $0.created)})
//    }
}
