//
//  RMCharacterDetailViewController.swift
//  RXExample
//
//  Created by DAVIDPAN on 2023/1/31.
//

import RxCocoa
import UIKit
import RxSwift

class CharacterDetailViewController: BaseViewController {
    
    // MARK: Identifier
    static let reuseIdentifier = "CharacterDetailViewController"
    
    // MARK: Dependencies
    var character: Character
    
    // MARK: Outlets
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var headPhotoImageView: CircleImageView = {
        let imageView = CircleImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    private lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.textColor = .fillGray
        return label
    }()
    
    private let divideLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .fillGray
        return view
    }()
    
    private lazy var typeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.textColor = .fillGray
        return label
    }()
    
    private lazy var statusTypeCardView: TypeCardView = {
        let typeCardView = TypeCardView()
        typeCardView.title = "Status"
        typeCardView.value = "-"
        return typeCardView
    }()
    
    private lazy var speciesTypeCardView: TypeCardView = {
        let typeCardView = TypeCardView()
        typeCardView.title = "Species"
        typeCardView.value = "-"
        return typeCardView
    }()
    
    private lazy var genderTypeCardView: TypeCardView = {
        let typeCardView = TypeCardView()
        typeCardView.title = "Gender"
        typeCardView.value = "-"
        return typeCardView
    }()
    
    // MARK: Private Properties
    private var viewModel: CharacterDetailViewModel
   
    
    private let disposeBag = DisposeBag()
    
    init(character: Character, viewModel: CharacterDetailViewModel = CharacterDetailViewModel()) {
        self.character = character
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bindView()
    }
    
    // MARK: Methods
    func initView() {
        
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let mainView = UIView()
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 10
        
        view.addSubview(mainView)
        
        mainView.addSubview(headPhotoImageView)
        headPhotoImageView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).offset(16)
            make.left.equalTo(mainView.snp.left).offset(16)
            make.height.width.equalTo(80)
        }
        
        mainView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(headPhotoImageView.snp.bottom).offset(8)
            make.left.equalTo(headPhotoImageView.snp.left)
        }
        
        mainView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(titleLabel.snp.left)
        }
        
        mainView.addSubview(createdDateLabel)
        createdDateLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(8)
            make.left.equalTo(typeLabel.snp.left)
        }
        
        mainView.addSubview(divideLineView)
        divideLineView.snp.makeConstraints { make in
            make.top.equalTo(createdDateLabel.snp.bottom).offset(8)
            make.left.equalTo(mainView.snp.left).offset(8)
            make.right.equalTo(mainView.snp.right).inset(8)
            make.height.equalTo(1)
        }
        let groupView = UIStackView(arrangedSubviews: [statusTypeCardView, speciesTypeCardView, genderTypeCardView])
        groupView.spacing = 4
        groupView.axis = .horizontal
        groupView.distribution = .fillEqually
        mainView.addSubview(groupView)
        
        groupView.snp.makeConstraints { make in
            make.top.equalTo(divideLineView.snp.bottom).offset(16)
            make.left.equalTo(mainView.snp.left).inset(8)
            make.right.equalTo(mainView.snp.right).inset(8)
            make.bottom.equalTo(mainView.snp.bottom).inset(16)
        }
        
        mainView.snp.makeConstraints { make in
            //make.height.equalTo(view.snp.height).multipliedBy(0.4)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
        
        
        
    }
    
    func bindView() {
        
        // MARK: - Outputs
        viewModel.output.downloadImage
            .drive(onNext: {[weak self] image in
                self?.backgroundImageView.image = image
                self?.headPhotoImageView.image = image
            })
            .disposed(by: disposeBag)
        
        viewModel.output.titleLabelText
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.typeLabelText
            .drive(typeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.createDateLabelText
            .drive(createdDateLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.speciesLabelText
            .drive(onNext: {[weak self] text in
                self?.speciesTypeCardView.value = text
            })
            .disposed(by: disposeBag)
        
        viewModel.output.statusLabelText
            .drive(onNext: {[weak self] text in
                self?.statusTypeCardView.value = text
            })
            .disposed(by: disposeBag)
        
        viewModel.output.genderLabelText
            .drive(onNext: {[weak self] text in
                self?.genderTypeCardView.value = text
            })
            .disposed(by: disposeBag)
        
        // MARK: - Inputs
        viewModel.input.characterSubject.onNext(character)
    

        
    }
    

   
    
    
}
