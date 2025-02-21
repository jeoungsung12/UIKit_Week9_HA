//
//  DialogViewController.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class PopupViewController: BaseViewController {
    private let containerView = UIView()
    private let profileView = ProfileView()
    private let spacer = UIView()
    private let descriptionLabel = UILabel()
    
    private let stackView = UIStackView()
    private let cancelBtn = UIButton()
    private let startBtn = UIButton()
    
    private let viewModel: PopupViewModel
    private var disposeBag = DisposeBag()

    init(viewModel: PopupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func setBinding() {
        let input = PopupViewModel.Input(startBtnTrigger: startBtn.rx.tap)
        let output = viewModel.transform(input)
        
        output.iconResult
            .drive(with: self) { owner, model in
                owner.profileView.configure(model)
                owner.descriptionLabel.text = model.description
            }
            .disposed(by: disposeBag)
        
        output.startBtnResult
            .drive(with: self) { owner, _ in
                owner.dismiss(animated: true)
                owner.setRootView(MainViewController())
            }
            .disposed(by: disposeBag)
        
        cancelBtn.rx.tap
            .asDriver()
            .drive(with: self) { owner, value in
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        self.view.backgroundColor = .black.withAlphaComponent(0.2)
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .background
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        spacer.backgroundColor = .labelText
        
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        descriptionLabel.textColor = .labelText
        descriptionLabel.textAlignment = .center
        
        cancelBtn.setTitle("취소", for: .normal)
        startBtn.setTitle("시작하기", for: .normal)
        [cancelBtn, startBtn].forEach({
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.labelText.withAlphaComponent(0.5).cgColor
            $0.setTitleColor(.labelText, for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        })
        
    }
    
    override func configureHierarchy() {
        [cancelBtn, startBtn].forEach({
            self.stackView.addArrangedSubview($0)
        })
        [profileView, spacer, descriptionLabel, stackView].forEach({
            self.containerView.addSubview($0)
        })
        self.view.addSubview(containerView)
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
            make.horizontalEdges.equalToSuperview().inset(28)
        }
        
        profileView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
            make.top.horizontalEdges.equalToSuperview().inset(24)
        }
        
        spacer.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(profileView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(48)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(spacer.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        stackView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.lessThanOrEqualTo(descriptionLabel.snp.bottom).offset(12)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(2)
            make.leading.equalToSuperview().offset(-2)
        }
        
        startBtn.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.trailing.equalToSuperview().offset(2)
        }
    }
    
    deinit {
        print(#function, self)
    }
    
}
