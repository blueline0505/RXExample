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
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
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
            make.left.equalTo(mainView.snp.left)
            make.right.equalTo(mainView.snp.right)
            make.bottom.equalTo(mainView.snp.bottom)
            make.top.equalTo(mainView.snp.top)
        }
        
    }
    
    private func bindView() {
        disposeBag = DisposeBag()
        
        viewModel.output.backgroundColor
            .drive(onNext: { [weak self] color in
                self?.mainView.backgroundColor = color
            })
            .disposed(by: disposeBag)
                   
    }
    
    public func configure(title: String, isSelected: Bool) {
        viewModel.input.titleLabelSubject.onNext(title)
        viewModel.input.selectedSubject.onNext(isSelected)
    }
    
}
