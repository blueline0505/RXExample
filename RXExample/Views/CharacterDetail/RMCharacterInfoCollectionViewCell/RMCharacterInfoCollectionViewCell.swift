//
//  RMCharacterInfoCollectionViewCell.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/2/2.
//

import UIKit
import RxSwift

class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    // MARK: Identifier
    static let identifier = "RMCharacterInfoCollectionViewCell"
    
    // MARK: Dependencies
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Private Properties
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }
    
    func setDataWithValue(_ data: CharacterDetailInfoItem) {
        titleLabel.text = data.type.displayTitle
        titleLabel.textColor = data.type.tintColor
        iconImageView.image = data.type.iconImage
        iconImageView.tintColor = data.type.tintColor
        valueLabel.text = data.displayValue
    }
    
}
