//
//  MainViewController.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController {
    private let settingBarBtn = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: nil, action: nil)
    private lazy var gestureTapped = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
    private let containerView = UIView()
    private let bubbleImageView = UIImageView()
    private let bubbleLabel = UILabel()
    private let profileView = ProfileView()
    private let levelLabel = UILabel()
    private let gameView = GameView()
    
    private let viewModel = MainViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setBinding() {
        let input = MainViewModel.Input(
            foodBtnTrigger: PublishSubject<String>(),
            waterBtnTrigger: PublishSubject<String>()
        )
        let output = viewModel.transform(input)
        
        settingBarBtn.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                owner.push(SettingViewController())
            }
            .disposed(by: disposeBag)
        
        gameView.foodButton.rx.tap
            .withLatestFrom(gameView.foodTextField.rx.text)
            .bind(with: self, onNext: { owner, value in
                input.foodBtnTrigger.onNext(value ?? "1")
            })
            .disposed(by: disposeBag)
        
        gameView.waterButton.rx.tap
            .withLatestFrom(gameView.waterTextField.rx.text)
            .bind(with: self, onNext: { owner, value in
                input.waterBtnTrigger.onNext(value ?? "1")
            })
            .disposed(by: disposeBag)
        
        output.userInfoResult
            .drive(with: self) { owner, model in
                owner.setNavigation(model.nickname + "님의 다마고치")
                owner.profileView.configure(model.iconData)
                owner.levelLabel.text = model.statusValue
                [owner.gameView.foodTextField, owner.gameView.waterTextField]
                    .forEach {
                        $0.text = nil
                    }
            }
            .disposed(by: disposeBag)
        
        //TODO: SetValue
        bubbleLabel.text = "테이블뷰컨트롤러와 뷰컨트롤러는 어떤 차이가 있을까요?"
    }
    
    override func configureView() {
        self.view.backgroundColor = .background
        self.navigationItem.rightBarButtonItem = settingBarBtn
        self.containerView.backgroundColor = .background
        bubbleImageView.image = UIImage(named: "bubble")
        bubbleImageView.contentMode = .scaleToFill
        
        bubbleLabel.numberOfLines = 0
        [bubbleLabel, levelLabel].forEach({
            $0.textColor = .labelText
            $0.textAlignment = .center
            $0.font = .boldSystemFont(ofSize: 15)
        })
        
    }
    
    override func configureHierarchy() {
        bubbleImageView.addSubview(bubbleLabel)
        [bubbleImageView, profileView, levelLabel, gameView]
            .forEach({ self.containerView.addSubview($0) })
        self.view.addSubview(containerView)
        self.view.addGestureRecognizer(gestureTapped)
    }
    
    override func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top)
        }
        
        bubbleImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(5)
            make.horizontalEdges.equalToSuperview().inset(52)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(36)
        }
        
        bubbleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview().inset(24)
        }
        
        profileView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
            make.top.equalTo(bubbleImageView.snp.bottom).offset(12)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        gameView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.5)
            make.top.equalTo(levelLabel.snp.bottom).offset(12)
            make.bottom.lessThanOrEqualToSuperview().inset(24)
        }
    }
    
    deinit {
        print(#function, self)
    }
    
}
