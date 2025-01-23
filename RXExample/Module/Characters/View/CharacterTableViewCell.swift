//
//  CharacterTableViewCell.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/30.
//

import UIKit
import RxSwift

class CharacterListTableCell: UITableViewCell {
    // MARK: Identifier
    static let identifier = "CharacterListTableCell"
    
    // MARK: Dependencies
    var viewModel = CharacterListTableCellViewModel()
    
    // MARK: Outlets
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: Private Properties
    private let imageSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       //bindViewModel()
    }
    
//    func setDataWithValue(_ character: Character) {
//        titleLabel.text = character.name
//        subtitleLabel.text = character.gender.rawValue
//        imageSubject.onNext(character.imagePath)
//    }
//    
//    func bindViewModel() {
//        // Inputs
//        imageSubject
//            .subscribe(viewModel.input.imagePathObserver)
//            .disposed(by: disposeBag)
//        
//        // Outputs
//        viewModel.output.downloadImage
//            .drive(iconImageView.rx.image)
//            .disposed(by: disposeBag)
//    }
}
