//
//  TagCollectionHeader.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/27.
//

import UIKit

class TagCollectionHeader: UICollectionReusableView {
    
    static let reuseIdentifier = "TagCollectionHeader"
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(8)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with title: String) {
        self.titleLabel.text = title
    }
    
}
