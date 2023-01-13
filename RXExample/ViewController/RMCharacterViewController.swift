//
//  RTCharacterViewController.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/27.
//

import RxSwift
import RxCocoa
import UIKit

class RMCharacterViewController: BaseViewController {
    // MARK: Identifier
    static let identifier = "RMCharacterViewController"
    
    // MARK: Dependencies
    var viewModel = RMCharacterViewModel()
    
    // MARK: Outlets
    @IBOutlet weak var characterTableView: UITableView!
    
    
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
        setupRefreshControl()
        setupTableView()
        bindViewModel()
    }
    
    // MARK: Methods
    func bindViewModel() {
        // Inputs
        refreshSubject
            .subscribe(viewModel.input.viewDidRefresh)
            .disposed(by: disposeBag)
        
        // Outputs
        // - TableView
        viewModel.output.characters
            .drive(characterTableView.rx.items(cellIdentifier: CharacterTableViewCell.identifier,
                                               cellType: CharacterTableViewCell.self)) {(row, data, cell) in
                cell.setDataWithValue(data)
                
            }.disposed(by: disposeBag)
        
        characterTableView.rx.modelSelected(Character.self)
            .subscribe(onNext: { item in
                print("selected:\(item.name)")
            }).disposed(by: disposeBag)
        // - Loading
        viewModel.output.isLoading.drive(onNext: { [unowned self] isLoading in
            self.showLoadingIndicators(isLoading)
        }).disposed(by: disposeBag)
        // - Error
        viewModel.output.error.drive(onNext: { [unowned self] error in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        characterTableView.addSubview(refreshControl)
    }
    
    func setupTableView() {
        characterTableView.register(UINib(nibName: CharacterTableViewCell.identifier, bundle: nil),
                                    forCellReuseIdentifier: CharacterTableViewCell.identifier)
    }
    
    @objc private func refreshControlValueChanged() {
        refreshSubject.onNext(())
    }
    
    private func showLoadingIndicators(_ isLoading: Bool) {
        if !isLoading {
            refreshControl.endRefreshing()
            print("endRefreshing")
        }else {
            print("startRefreshing")
        }
    }
}
