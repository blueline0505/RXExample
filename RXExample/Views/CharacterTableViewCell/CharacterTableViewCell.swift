//
//  CharacterTableViewCell.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/30.
//

import UIKit
import RxSwift

class CharacterTableViewCell: UITableViewCell {
    // MARK: Identifier
    static let identifier = "CharacterTableViewCell"
    
    // MARK: Dependencies
    var viewModel = CharacterTableViewCellViewModel()
    
    // MARK: Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: Private Properties
    private let imageSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bindViewModel()
    }
    
    func setDataWithValue(_ character: Character) {
        titleLabel.text = character.name
        subtitleLabel.text = character.gender.rawValue
        imageSubject.onNext(character.imagePath)
    }
    
    func bindViewModel() {
        // Inputs
        imageSubject
            .subscribe(viewModel.input.imagePathObserver)
            .disposed(by: disposeBag)
        
        // Outputs
        viewModel.output.donwloadImage
            .drive(iconImageView.rx.image)
            .disposed(by: disposeBag)
    }
}
