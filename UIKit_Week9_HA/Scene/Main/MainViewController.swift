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
        let input = MainViewModel.Input()
        let output = viewModel.transform(input)
        
        settingBarBtn.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                owner.push(SettingViewController())
            }
            .disposed(by: disposeBag)
        
        output.userInfoResult
            .drive(with: self) { owner, model in
                owner.setNavigation(model.nickname + "님의 다마고치")
                owner.profileView.configure(model.iconData)
                owner.levelLabel.text = model.statusValue
            }
            .disposed(by: disposeBag)
        
        //TODO: SetValue
        bubbleLabel.text = "테이블뷰컨트롤러와 뷰컨트롤러는 어떠너 차이가 있을까요?"
    }
    
    override func configureView() {
        self.view.backgroundColor = .background
        self.navigationItem.rightBarButtonItem = settingBarBtn
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
            .forEach({ self.view.addSubview($0) })
    }
    
    override func configureLayout() {
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
