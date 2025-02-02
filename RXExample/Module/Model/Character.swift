//
//  DataModel.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/27.
//
import UIKit.UIImage
import Foundation

struct Character {
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

extension Character {
    static func samlpleData() -> Character {
        let origin = RMCharacterOrigin(name: "Earth", url: "https://rickandmortyapi.com/api/location/1")
        let location = RMCharacterLocation(name: "Earth", url: "https://rickandmortyapi.com/api/location/20")
        let episode = [ "https://rickandmortyapi.com/api/episode/1",
                         "https://rickandmortyapi.com/api/episode/2"]
        
        return Character(id: 1,
                         name: "Rick Sanchez",
                         status: .Alive,
                         species: .unknown,
                         type: "",
                         gender: .Male,
                         origin: origin,
                         location: location,
                         imagePath: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                         episode: episode,
                         url: "https://rickandmortyapi.com/api/character/1",
                         created: Date())
    }
}
