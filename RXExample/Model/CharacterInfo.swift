//
//  CharacterInfo.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/1/31.
//

import Foundation
import UIKit.UIImage

struct CharacterInfo {
    
    // MARK: Private
    private let type: ˋTypeˋ
    private let value: String
    
    // MARK: Public
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        guard !value.isEmpty else { return "None" }
        return value
    }
    
    enum ˋTypeˋ {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemPurple
            case .species:
                return .systemGreen
            case .origin:
                return .systemOrange
            case .created:
                return .systemPink
            case .location:
                return .systemYellow
            case .episodeCount:
                return .systemTeal
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status:
                return ""
            case .gender:
                return ""
            case .type:
                return ""
            case .species:
                return ""
            case .origin:
                return ""
            case .created:
                return ""
            case .location:
                return ""
            case .episodeCount:
                return ""
            }
        }
    }
    
    init(type: ˋTypeˋ, value: String) {
        self.type = type
        self.value = value
    }
}
