//
//  CharacterFilterViewModel.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/27.
//

import RxSwift
import RxCocoa

class CharacterFilterViewModel: ViewModel {
    
    // MARK: Inputs
    let input: Input
    
    struct Input {
        let updateGender: BehaviorRelay<String>
        let updateSpecies: BehaviorRelay<String>
    }
    
    // MARK: Outputs
    let output: Output
    struct Output {
        let filterSections: Driver<[FilterSection]>
    }
    
    // MARK: Private
    private let disposeBag = DisposeBag()
    private let genderRelay: BehaviorRelay<String>
    private let speciesRelay: BehaviorRelay<String>
    
    deinit {
        print("CharacterFilterViewModel deinit")
    }
    
    init(species: String, gender: String) {
        speciesRelay = BehaviorRelay(value: species)
        genderRelay = BehaviorRelay(value: gender)
        
        let allSpecies = RMCharacterSpecie.allCases.map { FilterItem(title: $0.rawValue, selected: false) }
        let allGender = RMCharacterGender.allCases.map { FilterItem(title: $0.rawValue, selected: false) }
        
        let speciesSection = FilterSection(headerTitle: "Species", items: allSpecies)
        let genderSection = FilterSection(headerTitle: "Gender", items: allGender)
        
        input = Input(updateGender: genderRelay, updateSpecies: speciesRelay)
        
        let filterSections = Observable
            .combineLatest(genderRelay, speciesRelay) { selectedGender, selectedSpecies -> [FilterSection] in
                let allSpeciers = allSpecies.map { FilterItem(title: $0.title, selected: $0.title == selectedSpecies) }
                let allGender = allGender.map { FilterItem(title: $0.title, selected: $0.title == selectedGender) }
                
                let speciesSection = FilterSection(headerTitle: "Species", items: allSpeciers)
                let genderSection = FilterSection(headerTitle: "Gender", items: allGender)
                
                return [speciesSection, genderSection]
            }.asDriver(onErrorJustReturn: ([speciesSection, genderSection]))
        
        output = Output(filterSections: filterSections)
    }
    
}
