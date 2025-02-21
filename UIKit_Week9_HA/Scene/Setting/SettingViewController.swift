//
//  SettingViewController.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SettingViewController: BaseViewController {
    private let tableView = UITableView()
    private let viewModel = SettingViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setBinding() {
        SettingViewModel.Output().settingList
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.tintColor = .labelText
                cell.backgroundColor = .background
                cell.textLabel?.text = element.title
                cell.contentView.backgroundColor = .background
                cell.imageView?.image = UIImage(systemName: element.image)
            }
            .disposed(by: disposeBag)
            
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(SettingViewModel.SettingType.self))
            .observe(on: MainScheduler.instance)
            .map { $0.1 }
            .bind(with: self) { owner, type in
                switch SettingViewModel.SettingType.allCases[type.rawValue] {
                case .setName:
                    owner.push(SettingNameViewController())
                case .changeProfile:
                    owner.push(OnboardingViewController())
                case .reset:
                    owner.customAlert(
                        "데이터 초기화",
                        "정말 다시 시작하실 건가용?",
                        [.cancel, .ok]) {
                        owner.viewModel.removeUserInfo()
                        owner.setRootView(OnboardingViewController())
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        setNavigation("설정")
        self.view.backgroundColor = .background
        tableView.backgroundColor = .background
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func configureHierarchy() {
        self.view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaInsets)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    
}
