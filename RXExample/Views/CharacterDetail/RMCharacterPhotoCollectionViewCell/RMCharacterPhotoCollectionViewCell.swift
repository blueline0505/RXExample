//
//  RMCharacterPhotoCollectionViewCell.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/2/2.
//

import UIKit
import RxSwift

class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    // MARK: Identifier
    static let identifier = "RMCharacterPhotoCollectionViewCell"
    
    // MARK: Dependencies
    private var viewModel = RMCharacterPhotoCollectionViewModel()
    
    // MARK: Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: Private Properties
    private let imageSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        bindViewModel()
    }
    
    func setDataWithValue(_ imagePath: String) {
        imageSubject.onNext(imagePath)
    }
    
    func bindViewModel() {
        // Inputs
        imageSubject
            .subscribe(viewModel.input.imagePathObserver)
            .disposed(by: disposeBag)
        
        // Outputs
        viewModel.output.downloadImage
            .drive(iconImageView.rx.image)
            .disposed(by: disposeBag)
    }
}
