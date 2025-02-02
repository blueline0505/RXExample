//
//  RTCharacterViewController.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/27.
//

import RxSwift
import RxCocoa
import UIKit
import SnapKit

class CharacterListViewController: BaseViewController {
    
    // MARK: Identifier
    static let identifier = "CharacterListViewController"
    
    // MARK: Dependencies
    var viewModel = CharacterListViewModel()
    
    // MARK: Outlets
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Character"
        searchController.searchBar.tintColor = .white // cancel text color
        searchController.searchBar.barTintColor = .white // text color
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField,
           let iconView = textField.leftView as? UIImageView {
            textField.textColor = .white // placeholder
            textField.attributedPlaceholder = NSAttributedString(string: "Search Character",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            
            iconView.tintColor = .white // icon
        }
        
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private lazy var rightButtonItem: UIBarButtonItem = {
        let buttonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"),
                                         style: .plain,
                                         target: nil,
                                         action: nil)
        return buttonItem
    }()
    
    private lazy var aliveTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Human"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var otheritleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Other"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var characterCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.bounds,
                                              collectionViewLayout: CharacterListCollectionFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CharacterCollectionCell.self,
                                forCellWithReuseIdentifier: CharacterCollectionCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var otherCharacterTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(OtherCharacterTableCell.self, forCellReuseIdentifier: OtherCharacterTableCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: Private Properties
    private let refreshSubject = PublishSubject<Void>()
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bindViewModel()
        //refreshControlValueChanged()
    }
    
    // MARK: Methods
    func initView() {
    
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = rightButtonItem
        navigationItem.searchController = searchController
        
        view.addSubview(aliveTitleLabel)
        aliveTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-8)
        }
        
        view.addSubview(characterCollectionView)
        characterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(aliveTitleLabel.snp.bottom).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(170)
        }
        
        view.addSubview(otheritleLabel)
        otheritleLabel.snp.makeConstraints { make in
            make.top.equalTo(characterCollectionView.snp.bottom).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-8)
        }
        
        view.addSubview(otherCharacterTableView)
        otherCharacterTableView.snp.makeConstraints { make in
            make.top.equalTo(otheritleLabel.snp.bottom).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        otherCharacterTableView.estimatedRowHeight = 140
        otherCharacterTableView.rowHeight = UITableView.automaticDimension
      
    }
    
    func bindViewModel() {
        // Inputs
        refreshSubject
            .subscribe(viewModel.input.viewDidRefresh)
            .disposed(by: disposeBag)
       
        searchController.searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.input.searchName)
            .disposed(by: disposeBag)
        
        // Outputs
        
        // - rightBarItem
        rightButtonItem.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.showFilterViewController()
            }).disposed(by: disposeBag)
        
        // - CollectionView
        viewModel.output.characters
            .drive(characterCollectionView.rx.items(cellIdentifier: CharacterCollectionCell.reuseIdentifier.self,
                                                    cellType: CharacterCollectionCell.self)) {(row, data, cell) in
                cell.configure(with: data)
            }
            .disposed(by: disposeBag)
        
        characterCollectionView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell, indexPath) in
                cell.setAnimation(y: -200)
            }))
            .disposed(by: disposeBag)
        
        // - TableView
        viewModel.output.otherCharacters
            .drive(otherCharacterTableView.rx.items(cellIdentifier: OtherCharacterTableCell.reuseIdentifier,
                                                    cellType: OtherCharacterTableCell.self)) {(row, data, cell) in
                cell.configure(with: data)
            }.disposed(by: disposeBag)
        
        otherCharacterTableView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell, indexPath) in
                cell.setAnimation(x: -200)
            })).disposed(by: disposeBag)
        
        otherCharacterTableView.rx.modelSelected(Character.self)
            .subscribe(onNext: { [weak self] item in
                self?.showDetailViewController(with: item)
            }).disposed(by: disposeBag)
        
        // - Loading
        viewModel.output.isLoading
            .drive(onNext: { [unowned self] isLoading in
                self.showLoadingIndicators(isLoading)
            }).disposed(by: disposeBag)
        
        // - Error
        viewModel.output.error.drive(onNext: { [unowned self] error in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }).disposed(by: disposeBag)
    
    }
    
    @objc private func refreshControlValueChanged() {
        print("DEBUG: refreshControlValueChanged")
        refreshSubject.onNext(())
    }
    
    private func showLoadingIndicators(_ isLoading: Bool) {
        if !isLoading {
            refreshControl.endRefreshing()
        }else {
            refreshControl.beginRefreshing()
        }
    }
    
    private func showDetailViewController(with character: Character) {
        let viewController = CharacterDetailViewController(character: character)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func showFilterViewController() {
        let viewController = CharacterFilterViewController(species: viewModel.input.speciesRelay.value,
                                                           gender: viewModel.input.genderRelay.value,
                                                           parentViewModel: viewModel)
        
        self.present(viewController, animated: true)
    }
    
}
