//
//  TagButton.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/24.
//

import UIKit
import RxSwift
import RxCocoa

class TagCollectionCell: UICollectionViewCell {
    
    // MARK: Identifier
    static let reuseIdentifier = "TagCollectionCell"
    
    // MARK: - Dependencies
    var viewModel = TagCollectionCellViewModel()
    
    private var disposeBag = DisposeBag()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
        bindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        
        addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        mainView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.left).offset(16)
            make.right.equalTo(mainView.snp.right).offset(-16)
            make.bottom.equalTo(mainView.snp.bottom).offset(-8)
            make.top.equalTo(mainView.snp.top).offset(8)
        }
        
    }
    
    private func bindView() {
        disposeBag = DisposeBag()
        
        viewModel.output.titleText
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.backgroundColor
            .drive(mainView.rx.backgroundColor)
            .disposed(by: disposeBag)
    }
    
    public func configure(title: String, isSelected: Bool) {
        viewModel.input.titleLabelSubject.onNext(title)
        viewModel.input.selectedSubject.onNext(isSelected)
    }
    
}
