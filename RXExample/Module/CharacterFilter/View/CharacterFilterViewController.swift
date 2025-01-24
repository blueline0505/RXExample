//
//  CharacterFilterViewController.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/24.
//

import UIKit

class CharacterFilterViewController: BaseViewController {
    
    
    private lazy var filterCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(TagCollectionCell.self,
                                forCellWithReuseIdentifier: TagCollectionCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .green
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
       let button = UIButton(type: .custom)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .fillGray
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bindView()
    }
    
    private func initView() {
        title = "CharacterFilter"
        
        let bottomStackView = UIStackView(arrangedSubviews: [cancelButton, applyButton])
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 8
        view.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(16)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(filterCollectionView)
        filterCollectionView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(16)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.bottom.equalTo(bottomStackView.snp.top).offset(16)
        }
    }
    
    private func bindView() {
        
    }
}
