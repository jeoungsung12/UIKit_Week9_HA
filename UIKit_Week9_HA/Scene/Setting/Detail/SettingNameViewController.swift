//
//  SettingNameViewController.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SettingNameViewController: BaseViewController {
    private let saveBtn = UIBarButtonItem(title: "저장", style: .plain, target: nil, action: nil)
    private let nameTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setBinding() {
        
    }
    
    override func configureView() {
        self.title = "대장님 이름 정하기"
        self.view.backgroundColor = .background
        self.navigationItem.rightBarButtonItem = saveBtn
        nameTextField.text = "고래밥"
        nameTextField.textColor = .labelText
        nameTextField.textAlignment = .left
        nameTextField.font = .boldSystemFont(ofSize: 14)
        
        let underlineView = UIView()
        underlineView.backgroundColor = .labelText
        nameTextField.addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(8)
            make.height.equalTo(1)
        }
        
    }
    
    override func configureHierarchy() {
        self.view.addSubview(nameTextField)
    }
    
    override func configureLayout() {
        nameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
        }
    }
    
    
}
