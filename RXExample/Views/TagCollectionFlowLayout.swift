//
//  TagCollectionFlowLayout.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/27.
//

import UIKit

class TagCollectionFlowLayout: UICollectionViewFlowLayout {

    private let padding: CGFloat = 8.0
    private let headerHeight: CGFloat = 50
    
    override func prepare() {
        super.prepare()
        self.sectionInset = UIEdgeInsets(top: 4, left: padding, bottom: 4, right: padding)
        self.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: headerHeight)
        self.minimumInteritemSpacing = padding
        self.minimumLineSpacing = padding
        self.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        self.scrollDirection = .vertical
        self.sectionInsetReference = .fromSafeArea
        self.sectionHeadersPinToVisibleBounds = true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin: CGFloat = self.sectionInset.left
        var maxY: CGFloat = -1.0
        
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.frame.origin.y > maxY {
                    leftMargin = self.sectionInset.left
                }
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + self.minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
        attributes?.frame.origin.x = self.sectionInset.left
        return attributes
    }
    
}
