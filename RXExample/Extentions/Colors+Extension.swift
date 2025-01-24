//
//  Colors.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/27.
//

import UIKit

extension UIColor {
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return .init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static var fillYellow: UIColor {
        self.rgba(red: 255, green: 251, blue: 235, alpha: 1.0)
    }
    
    static var fillNavy: UIColor {
        self.rgba(red: 73, green: 85, blue: 121, alpha: 1.0)
    }
    
    static var fillWinter: UIColor {
        self.rgba(red: 38, green: 49, blue: 89, alpha: 1.0)
    }
    
    static var fillVintage: UIColor {
        self.rgba(red: 37, green: 23, blue: 73, alpha: 1.0)
    }
    
    static var fillGray: UIColor {
        self.rgba(red: 154, green: 155, blue: 159, alpha: 1.0)
    }
}
