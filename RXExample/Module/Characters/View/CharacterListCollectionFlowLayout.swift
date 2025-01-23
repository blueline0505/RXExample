//
//  CharacterListCollectionLayout.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/22.
//

import UIKit

class CharacterListCollectionFlowLayout: UICollectionViewFlowLayout {

    private let columns: Int = 3
    private let padding: CGFloat = 5.0
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let cellWidth = (availableWidth / CGFloat(columns)).rounded(.down)
        
        
        self.itemSize = CGSize(width: cellWidth, height: cellWidth)
        self.minimumInteritemSpacing = padding
        self.minimumLineSpacing = padding
        self.sectionInset = UIEdgeInsets(top: padding,
                                         left: padding,
                                         bottom: padding,
                                         right: padding)
        self.scrollDirection = .horizontal
        self.sectionInsetReference = .fromSafeArea
    }
    
   
}
