//
//  RMCharacterDetailViewController.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/1/31.
//

import RxCocoa
import UIKit
import RxSwift
import RxDataSources

class RMCharacterDetailViewController: BaseViewController {
    
    // MARK: Identifier
    static let identifier = "RMCharacterDetailViewController"
    
    // MARK: Dependencies
    var character: Character!
    
    // MARK: Outlets
    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    // MARK: Private Properties
    private var viewModel = RMCharacterDetailViewModel()
    private let characterSubject = PublishSubject<Character>()
    private var collectionLayout = UICollectionViewLayout()
    private let disposeBag = DisposeBag()
    
    func dataSource() -> RxCollectionViewSectionedReloadDataSource<CharacterDetailSection> {
        let datasource = RxCollectionViewSectionedReloadDataSource<CharacterDetailSection>(configureCell: {(dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
            switch dataSource[indexPath] {
            case .ImageItem(let data):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCollectionViewCell.identifier, for: indexPath) as? RMCharacterPhotoCollectionViewCell
                else { return UICollectionViewCell() }
                cell.setDataWithValue(data.imagePath)
                return cell
            case .InfoItem(let data):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCollectionViewCell.identifier, for: indexPath) as? RMCharacterInfoCollectionViewCell
                else { return UICollectionViewCell() }
                cell.setDataWithValue(data)
                return cell
            case .EpisoItem(let data):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.identifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else { return UICollectionViewCell() }
                cell.setDataWithValue(data)
                return cell
            }
        })
        return datasource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindViewModel()
        
        characterSubject.onNext(character)
    }
    
    // MARK: Methods
    func bindViewModel() {
        // Inputs
        characterSubject
            .subscribe(viewModel.input.character)
            .disposed(by: disposeBag)
    
        viewModel.output
            .characterInfos
            .drive(characterCollectionView.rx.items(dataSource: self.dataSource()))
            .disposed(by: disposeBag)
        
    }
    
    // MARK: Layouts
    private func setupCollectionView() {
        characterCollectionView.collectionViewLayout = createLayout()
        characterCollectionView.register(UINib(nibName: RMCharacterPhotoCollectionViewCell.identifier, bundle: nil),
                                         forCellWithReuseIdentifier: RMCharacterPhotoCollectionViewCell.identifier)
        characterCollectionView.register(UINib(nibName: RMCharacterInfoCollectionViewCell.identifier, bundle: nil),
                                         forCellWithReuseIdentifier: RMCharacterInfoCollectionViewCell.identifier)
        characterCollectionView.register(UINib(nibName: RMCharacterEpisodeCollectionViewCell.identifier, bundle: nil),
                                         forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.identifier)
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return self.createPhotoSectionLayout()
            case 1: return self.createInfoSectionLayout()
            case 2: return self.createEpisodeSectionLayout()
            default:
                return self.createInfoSectionLayout()
            }
        }
    }
    
    private func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
}
