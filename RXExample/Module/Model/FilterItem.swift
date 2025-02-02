//
//  TypeTag.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/24.
//

import RxDataSources

struct FilterSection {
    let headerTitle: String
    var items: [FilterItem]
}

struct FilterItem {
    let title: String
    var selected: Bool
}

extension FilterSection: SectionModelType {
    typealias Item = FilterItem
    
    init(original: FilterSection, items: [FilterItem]) {
        self = original
        self.items = items 
    }
}
