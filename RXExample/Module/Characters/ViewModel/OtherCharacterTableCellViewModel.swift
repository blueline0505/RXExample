//
//  CharacterTableViewCellViewModel.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/1/13.
//

import Foundation
import UIKit.UIImage
import RxSwift
import RxCocoa

class OtherCharacterTableCellViewModel: ViewModel {
    
    // MARK: Input
    let input: Input
    
    struct Input {
        let characterSubject: BehaviorSubject<Character?>
    }
    
    private let characterSubject: BehaviorSubject<Character?> = .init(value: nil)
    
    // MARK: Output
    let output: Output
    
    struct Output {
        let titleLabelText: Driver<String>
        let subtitleLabelText: Driver<String>
        let downloadImage: Driver<UIImage?>
    }
    
    // MARK: Private properties
    private let downloadImageSubject = PublishSubject<UIImage?>()
    private let disposeBag = DisposeBag()
    
    // MARK: Initialisation
    
    init() {
        input = Input(characterSubject: characterSubject)
        
        let titleLabelText = characterSubject
            .map { $0?.name ?? "-" }
            .asDriver(onErrorJustReturn: "-")
        
        let subtitleLabelText = characterSubject
            .map { $0?.type ?? "-" }
            .asDriver(onErrorJustReturn: "-")
        
        let downloadImageSubject = characterSubject
            .compactMap { $0?.imagePath }
            .flatMap { imagePath in
                try APIMangger.shared().downloadImage(imagePath)
            }.asDriver(onErrorJustReturn: nil)
        
        output = Output(titleLabelText: titleLabelText,
                        subtitleLabelText: subtitleLabelText,
                        downloadImage: downloadImageSubject.asDriver(onErrorJustReturn: nil))
    }
}
