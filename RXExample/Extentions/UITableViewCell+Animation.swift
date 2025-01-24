//
//  UITableViewCell+Animation.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/24.
//

import UIKit

extension UITableViewCell {
    
    func setAnimation(x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) {
        self.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, x, y, z)
        self.layer.transform = transform
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut,
                       animations: {
            self.alpha = 1
            self.layer.transform = CATransform3DIdentity}, completion: nil)
    }
}
