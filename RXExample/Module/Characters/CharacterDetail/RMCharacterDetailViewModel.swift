//
//  RMCharacterDetailViewModel.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/1/31.
//

import UIKit.UIImage
import RxSwift
import RxCocoa

class RMCharacterDetailViewModel: ViewModel {
    
    // MARK: Inputs
    let input: Input
    
    struct Input {
        let character: AnyObserver<Character>
    }
    
    private let characterSubject = PublishSubject<Character>()
    
    // MARK: Outputs
    let output: Output
    
    struct Output {
        let characterInfos: Driver<[CharacterDetailSection]>
    }
    
    // MARK: Private properties
    private let disposeBag = DisposeBag()
    
    // MARK: Initialisation
    init() {
        input = Input(character: characterSubject.asObserver())
        
        // character convert to infos
        let characterInfosSubject = characterSubject
            .asObservable()
            .map({ item in
                [
                    CharacterDetailSection(header: "", items: [
                        .ImageItem(data: CharacterDetailImageItem(imagePath: item.imagePath))
                    ]),
                    CharacterDetailSection(header: "", items: [
                        .InfoItem(data: CharacterDetailInfoItem(type: .status, value: item.status.rawValue)),
                        .InfoItem(data: CharacterDetailInfoItem(type: .gender, value: item.gender.rawValue)),
                        .InfoItem(data: CharacterDetailInfoItem(type: .type, value: item.type)),
                        .InfoItem(data: CharacterDetailInfoItem(type: .species, value: item.species)),
                        .InfoItem(data: CharacterDetailInfoItem(type: .origin, value: item.origin.name)),
                        .InfoItem(data: CharacterDetailInfoItem(type: .location, value: item.location.name)),
                        .InfoItem(data: CharacterDetailInfoItem(type: .created, value: item.created.toShortString())),
                        .InfoItem(data: CharacterDetailInfoItem(type: .episodeCount, value: "\(item.episode.count)"))
                    ]),
                    CharacterDetailSection(header: "", items: [
                        .EpisoItem(data: CharacterDetailEpisoItem(paths: item.episode))
                    ]),
                ]
            })
            .asDriver { error in
                return Driver.just([])
            }
        
        output = Output(characterInfos: characterInfosSubject.asDriver(onErrorJustReturn: []))
    }
}
