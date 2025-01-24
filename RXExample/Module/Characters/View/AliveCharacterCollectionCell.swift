//
//  CharacterListCollectionCell.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/22.
//

import UIKit
import RxSwift
import RxCocoa

class AliveCharacterCollectionCell: UICollectionViewCell {
    
    // MARK: Identifier
    static let reuseIdentifier = "AliveCharacterCollectionCell"
    
    // MARK: - Dependencies
    var viewModel = AliveCharacterCollectionCellViewModel()
   
    
    // MARK: - Properties
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "anonymous"
        label.textAlignment = .center
        label.textColor = UIColor.blue
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Private Properties
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        bindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        let topView = UIView()
        topView.addSubview(characterImageView)
        
        let stackView = UIStackView(arrangedSubviews: [topView, titleLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints { make in
            make.width.equalTo(topView).multipliedBy(0.8)
            make.centerX.centerY.equalTo(topView)
            make.height.equalTo(characterImageView.snp.width).multipliedBy(1.0)
        }
    }
    
    private func bindView() {
        disposeBag = DisposeBag()
        
        viewModel.output.titleLabelText
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.downloadImage
            .drive(onNext: { [weak self] image in
                self?.characterImageView.image = image
            })
            .disposed(by: disposeBag)
    }
    
    public func configure(with data: Character) {
        self.viewModel.input.characterSubject.onNext(data)
    }
    
  
}
