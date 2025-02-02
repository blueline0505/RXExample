//
//  TagCollectionCellViewModel.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/24.
//

import RxSwift
import RxCocoa

class TagCollectionCellViewModel: ViewModel {
    
    // MAKR: Input
    let input: Input
    
    struct Input {
        let titleLabelSubject: BehaviorSubject<String>
        let selectedSubject: BehaviorSubject<Bool>
    }
    
    // MARK: Output
    let output: Output
    
    struct Output {
        let titleText: Driver<String>
        let backgroundColor: Driver<UIColor>
    }
    
    // MARK: properties
    private let titleLabelSubject: BehaviorSubject<String> = .init(value: "")
    private let selectedSubject: BehaviorSubject<Bool> = .init(value: false)
    
    init() {
   
        input = Input(titleLabelSubject: titleLabelSubject, selectedSubject: selectedSubject)
        
        let titleText = titleLabelSubject.map { $0 }
            .asDriver(onErrorJustReturn: "")
        
        let backgroundColor = selectedSubject.map { isSelected in
            return isSelected ? .systemBlue : .lightGray
        }.asDriver(onErrorJustReturn: UIColor.lightGray)
        
        output = Output(
            titleText: titleText,
            backgroundColor: backgroundColor
        )
    }
    
    
}
