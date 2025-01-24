//
//  TypeCardView.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/24.
//

import UIKit

class TypeCardView: UIView {
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var value: String? {
        didSet {
            valueLabel.text = value
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
