//
//  RMCharacterDetailViewModel.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/1/31.
//

import UIKit.UIImage
import RxSwift
import RxCocoa

class CharacterDetailViewModel: ViewModel {
    
    // MARK: Inputs
    let input: Input
    
    struct Input {
        let characterSubject: BehaviorSubject<Character?>
    }
    
    private let characterSubject = BehaviorSubject<Character?>(value: nil)
    
    // MARK: Outputs
    let output: Output
    
    struct Output {
        let titleLabelText: Driver<String>
        let createDateLabelText: Driver<String>
        let typeLabelText: Driver<String>
        let speciesLabelText: Driver<String>
        let genderLabelText: Driver<String>
        let statusLabelText: Driver<String>
        let downloadImage: Driver<UIImage?>
    }
    
    // MARK: Private properties
    private let disposeBag = DisposeBag()
    
    // MARK: Initialisation
    init() {
        input = Input(characterSubject: characterSubject)
        
        let titleLabelTextSubject = characterSubject
            .map { $0?.name ?? "-" }
            .asDriver(onErrorJustReturn: "-")
        
        let createDateLabelTextSubject = characterSubject
            .map { $0?.created.toString(outputFormat: "yyyy-MM-dd") ?? "-"}
            .asDriver(onErrorJustReturn: "-")
        
        let typeLabelTextSubject = characterSubject
            .map { $0?.type ?? "" }
            .asDriver(onErrorJustReturn: "-")
        
        let speciesLabelTextSubject = characterSubject
            .map { $0?.species.rawValue ?? RMCharacterSpecie.unknown.rawValue }
            .asDriver(onErrorJustReturn: "-")
        
        let genderLabelTextSubject = characterSubject
            .map { $0?.gender.rawValue ?? "" }
            .asDriver(onErrorJustReturn: "-")
        
        let statusLabelTextSubject = characterSubject
            .map { $0?.status.rawValue ?? "" }
            .asDriver(onErrorJustReturn: "-")
        
        let downloadImageSubject = characterSubject
            .compactMap { $0?.imagePath }
            .flatMap { imagePath in
                try APIMangger.shared().downloadImage(imagePath)
            }.asDriver(onErrorJustReturn: nil)
            
        
        output = Output(titleLabelText: titleLabelTextSubject,
                        createDateLabelText: createDateLabelTextSubject,
                        typeLabelText: typeLabelTextSubject,
                        speciesLabelText: speciesLabelTextSubject,
                        genderLabelText: genderLabelTextSubject,
                        statusLabelText: statusLabelTextSubject,
                        downloadImage: downloadImageSubject)
    }
}
