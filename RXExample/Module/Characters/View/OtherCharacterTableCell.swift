//
//  CharacterTableViewCell.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/30.
//

import UIKit
import RxSwift

class OtherCharacterTableCell: UITableViewCell {
    
    // MARK: Identifier
    static let reuseIdentifier = "OtherCharacterTableCell"
    
    // MARK: Dependencies
    var viewModel = OtherCharacterTableCellViewModel()
    
    // MARK: Outlets
    
    private lazy var iconImageView: CircleImageView = {
        let imageView = CircleImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Private Properties
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initView()
        bindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        
        let leftView = UIView()
        leftView.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.width.equalTo(60)
        }
        
        let verticalStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        verticalStack.axis = .vertical
        verticalStack.spacing = 4
        
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        subtitleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        let mainView = UIStackView(arrangedSubviews: [leftView, verticalStack])
        mainView.axis = .horizontal
        mainView.spacing = 8
        mainView.alignment = .top
        contentView.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().inset(8)
        }
        
        leftView.snp.makeConstraints { make in
            make.height.equalTo(iconImageView.snp.height)
        }
        
    }
    
    private func bindView() {
        disposeBag = DisposeBag()
        
        viewModel.output.titleLabelText
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.subtitleLabelText
            .drive(subtitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.downloadImage
            .drive(onNext: { [weak self] image in
                self?.iconImageView.image = image
            })
            .disposed(by: disposeBag)
    }
   
    public func configure(with data: Character) {
        self.viewModel.input.characterSubject.onNext(data)
    }
}
