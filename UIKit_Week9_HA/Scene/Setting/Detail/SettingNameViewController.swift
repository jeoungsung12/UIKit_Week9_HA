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
    
    private let viewModel = SettingNameViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setBinding() {
        let input = SettingNameViewModel.Input(saveBtnTrigger: PublishSubject<String>())
        let output = viewModel.transform(input)
        
        saveBtn.rx.tap
            .withLatestFrom(nameTextField.rx.text.orEmpty)
            .map { text in
                if text.count >= 2 && text.count <= 6 {
                    return text
                } else {
                    return ""
                }
            }
            .bind(with: self) { owner, text in
                if !text.isEmpty {
                    input.saveBtnTrigger.onNext(text)
                    owner.nameTextField.text = nil
                } else {
                    owner.customAlert("이름은 2글자 이상 6글자 이하까지 가능합니다.") { }
                }
            }
            .disposed(by: disposeBag)
        
        output.nickname
            .drive(with: self) { owner, nickname in
                self.title = nickname
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        self.view.backgroundColor = .background
        self.navigationItem.rightBarButtonItem = saveBtn
        nameTextField.textColor = .labelText
        nameTextField.textAlignment = .left
        nameTextField.placeholder = "변경할 닉네임을 입력해 주세요"
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
