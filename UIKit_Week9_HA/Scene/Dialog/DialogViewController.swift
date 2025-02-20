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

final class DialogViewController: BaseViewController {
    private let containerView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let spacer = UIView()
    private let descriptionLabel = UILabel()
    
    private let stackView = UIStackView()
    private let cancelBtn = UIButton()
    private let startBtn = UIButton()
    
    private let viewModel = DialogViewModel()
    private var disposeBag = DisposeBag()
    lazy var input = DialogViewModel.Input(
        startBtnTrigger: startBtn.rx.tap,
        iconImageTrigger: PublishSubject()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setBinding() {
        let output = viewModel.transform(input)
        
        output.iconResult
            .drive(with: self) { owner, model in
                owner.titleLabel.text = model.title
                owner.imageView.image = UIImage(named: model.image)
                owner.descriptionLabel.text = model.title + owner.viewModel.descriptionText
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
        
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.cornerRadius = 5
        titleLabel.backgroundColor = .labelBackground
        titleLabel.font = .boldSystemFont(ofSize: 13)
        titleLabel.layer.borderColor = UIColor.labelText.cgColor
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        spacer.backgroundColor = .labelText
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        [titleLabel, descriptionLabel].forEach({
            $0.textColor = .labelText
            $0.textAlignment = .center
        })
        
        cancelBtn.setTitle("취소", for: .normal)
        startBtn.setTitle("시작하기", for: .normal)
        [cancelBtn, startBtn].forEach({
            $0.setTitleColor(.labelText, for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        })
        
    }
    
    override func configureHierarchy() {
        [cancelBtn, startBtn].forEach({
            self.stackView.addArrangedSubview($0)
        })
        [imageView, titleLabel, spacer, descriptionLabel, stackView].forEach({
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
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
            make.top.horizontalEdges.equalToSuperview().inset(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        spacer.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(48)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(spacer.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
        }
    }
    
    deinit {
        print(#function, self)
    }
    
    
}
