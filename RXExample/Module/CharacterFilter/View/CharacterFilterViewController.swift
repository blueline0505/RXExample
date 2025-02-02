//
//  CharacterFilterViewController.swift
//  RXExample
//
//  Created by DAVIDPAN on 2025/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CharacterFilterViewController: BaseViewController {
    
    private lazy var filterCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: TagCollectionFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(TagCollectionCell.self,
                                forCellWithReuseIdentifier: TagCollectionCell.reuseIdentifier)
        collectionView.register(TagCollectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TagCollectionHeader.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Apply", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .fillNavy
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
    
    // MARK: - Properties
    var viewModel: CharacterFilterViewModel
    var parentViewModel: CharacterListViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    init(species: String, gender: String, parentViewModel: CharacterListViewModel) {
        self.viewModel = CharacterFilterViewModel(species: species, gender: gender)
        self.parentViewModel = parentViewModel
        print("DEBUG: CharacterFilterViewController init species:\(species), gender:\(gender)")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("CharacterFilterViewController deinit")
    }
    
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
            make.bottom.equalTo(bottomStackView.snp.top).offset(-16)
        }
    }
    
    private func bindView() {
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<FilterSection>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionCell.reuseIdentifier, for: indexPath) as! TagCollectionCell
                cell.configure(title: item.title, isSelected: item.selected)
                
                return cell
            },
            configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TagCollectionHeader.reuseIdentifier, for: indexPath) as? TagCollectionHeader else {
                    return UICollectionReusableView()
                }
                
                header.configure(with: dataSource.sectionModels[indexPath.section].headerTitle)
                return header
            }
        )
        
        filterCollectionView.rx.itemSelected
            .subscribe(onNext: {[weak self] indexPath in
                guard let self = self else { return }
                if indexPath.section == 1 {
                    let allGenders = RMCharacterGender.allCases.map { $0.rawValue }
                    let gender = allGenders[indexPath.row]
                    self.viewModel.input.updateGender.accept(self.viewModel.input.updateGender.value == gender ? "" : gender)
                }else {
                    let allSpecies = RMCharacterSpecie.allCases.map { $0.rawValue }
                    let species = allSpecies[indexPath.row]
                    self.viewModel.input.updateSpecies.accept(self.viewModel.input.updateSpecies.value == species ? "" : species)
                }
            })
            .disposed(by: disposeBag)
       
        viewModel.output.filterSections
            .drive(filterCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        applyButton.rx.tap
            .debounce(.milliseconds(100), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.parentViewModel.input.speciesRelay.accept(self.viewModel.input.updateSpecies.value)
                self.parentViewModel.input.genderRelay.accept(self.viewModel.input.updateGender.value)
                
                self.parentViewModel.input.viewDidRefresh.onNext(())
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
}
