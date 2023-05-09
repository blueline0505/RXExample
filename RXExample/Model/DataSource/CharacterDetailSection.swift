//
//  CharacterDetail.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/2/8.
//

import RxDataSources

struct CharacterDetailImageItem {
    let imagePath: String
}

struct CharacterDetailInfoItem {
    let type: ˋTypeˋ
    let value: String
    
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        return value.isEmpty ? "None" : value
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
                return "Status"
            case .gender:
                return "Gender"
            case .type:
                return "Type"
            case .species:
                return "Species"
            case .origin:
                return "Origin"
            case .created:
                return "Created"
            case .location:
                return "Location"
            case .episodeCount:
                return "EpisodeCount"
            }
        }
    }
}

struct CharacterDetailEpisoItem {
    let paths: [String]
}

enum CharacterDetailItem {
    case ImageItem(data: CharacterDetailImageItem)
    case InfoItem(data: CharacterDetailInfoItem)
    case EpisoItem(data: CharacterDetailEpisoItem)
}

struct CharacterDetailSection {
    var header: String
    var items: [CharacterDetailItem]
}

extension CharacterDetailSection: SectionModelType {
    typealias Item = CharacterDetailItem
    
    init(original: CharacterDetailSection, items: [Item]) {
        self = original
        self.items = items
    }
}


