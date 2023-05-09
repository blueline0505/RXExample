//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/2/2.
//

import UIKit
import RxSwift

class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    // MARK: Identifier
    static let identifier = "RMCharacterEpisodeCollectionViewCell"
    
    // MARK: Dependencies
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    
    // MARK: Private Properties
    private var viewModel = RMCharacterEpisodeCollectionViewModel()
    private let objectSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
       
    }
    
    func setDataWithValue(_ data: [String]) {
//        seasonLabel.text = "Episode \(data.title)"
//        nameLabel.text = data.value
//        airDateLabel.text = "Aired on \(data.title)"
        
    }
    
    func bindViewModel() {
        // Inputs
        
        // Outputs
        
    }
    
}
