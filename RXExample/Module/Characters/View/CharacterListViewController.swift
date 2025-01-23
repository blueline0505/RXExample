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
    
    private lazy var aliveTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Alive"
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
        collectionView.register(AliveCollectionCell.self,
                                forCellWithReuseIdentifier: AliveCollectionCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var otherTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = .fillNavy
        
        return tableView
    }()
    
    // MARK: Private Properties
   
    private let refreshSubject = PublishSubject<Void>()
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshControlValueChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bindViewModel()
    }
    
    // MARK: Methods
    func initView() {
        
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
        
        view.addSubview(otherTableView)
        otherTableView.snp.makeConstraints { make in
            make.top.equalTo(otheritleLabel.snp.bottom).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    func bindViewModel() {
        // Inputs
        refreshSubject
            .subscribe(viewModel.input.viewDidRefresh)
            .disposed(by: disposeBag)
        
        // Outputs
        
        // - CollectionView
        viewModel.output.characters
            .drive(characterCollectionView.rx.items(cellIdentifier: AliveCollectionCell.reuseIdentifier.self,
                                                    cellType: AliveCollectionCell.self)) {(row, data, cell) in
                cell.configure(with: data)
            }
            .disposed(by: disposeBag)
        
        characterCollectionView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell, indexPath) in
                self.fadeInOut(with: cell)
            }))
            .disposed(by: disposeBag)
        
        
        /*
        // - TableView
        viewModel.output.characters
            .drive(characterTableView.rx.items(cellIdentifier: CharacterListTableCell.identifier,
                                               cellType: CharacterListTableCell.self)) {(row, data, cell) in
                cell.setDataWithValue(data)
            }.disposed(by: disposeBag)
        
        characterTableView.rx.modelSelected(Character.self)
            .subscribe(onNext: { [unowned self] item in
                self.showDetailViewController(item)
            }).disposed(by: disposeBag)
        // - Loading
        viewModel.output.isLoading.drive(onNext: { [unowned self] isLoading in
            self.showLoadingIndicators(isLoading)
        }).disposed(by: disposeBag)
        // - Error
        viewModel.output.error.drive(onNext: { [unowned self] error in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }).disposed(by: disposeBag)
        */
    }
    
    /*
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        characterTableView.addSubview(refreshControl)
    }*/
    
    
    @objc private func refreshControlValueChanged() {
        refreshSubject.onNext(())
    }
    
    private func showLoadingIndicators(_ isLoading: Bool) {
        if !isLoading {
            refreshControl.endRefreshing()
            //print("endRefreshing")
        }else {
            //print("startRefreshing")
        }
    }
    
    private func showDetailViewController(_ character: Character) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: RMCharacterDetailViewController.identifier) as? RMCharacterDetailViewController else {
            return
        }
        viewController.character = character
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func fadeInOut(with cell: UICollectionViewCell) {
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -250, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut,
                       animations: {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
    }
    
}
