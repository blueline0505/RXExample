//
//  CicleImageView.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/24.
//

import UIKit

class CircleImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.size.width * 0.5
        clipsToBounds = true
    }
    
}
