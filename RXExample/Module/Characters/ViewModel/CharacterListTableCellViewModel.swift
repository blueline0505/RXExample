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

class CharacterListTableCellViewModel: ViewModel {
    
    // MARK: Input
    let input: Input
    
    struct Input {
        let imagePathObserver: AnyObserver<String>
    }
    
    private let imageSubject = PublishSubject<String>()
    
    // MARK: Output
    let output: Output
    
    struct Output {
        let downloadImage: Driver<UIImage?>
    }
    
    // MARK: Private properties
    private let downloadImageSubject = PublishSubject<UIImage?>()
    private let disposeBag = DisposeBag()
    
    // MARK: Initialisation
    
    init() {
        input = Input(imagePathObserver: imageSubject.asObserver())
        
        let downloadImageSubject = imageSubject
            .flatMap({ try APIMangger.shared().downloadImage($0) })
            .asDriver(onErrorJustReturn: nil)
        
        output = Output(downloadImage: downloadImageSubject.asDriver(onErrorJustReturn: nil))
    }
}
