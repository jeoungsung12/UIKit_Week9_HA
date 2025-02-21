//
//  SettingNameViewModel.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingNameViewModel: BaseViewModel {
    private var disposeBag = DisposeBag()
    private let descriptionText = "2글자 이상 6글자 이하까지 가능합니다."
    
    struct Input {
        let saveBtnTrigger: PublishSubject<String>
    }
    
    struct Output {
        let nickname: Driver<String>
    }
    
}

extension SettingNameViewModel {
    
    func transform(_ input: Input) -> Output {
        let nickname: BehaviorRelay<String> = BehaviorRelay(value: self.getNickname())
        
        input.saveBtnTrigger
            .bind(with: self) { owner, text in
                owner.setNickname(text)
                nickname.accept(owner.getNickname())
            }
            .disposed(by: disposeBag)
        
        return Output(
            nickname: nickname.asDriver()
        )
    }
    
    private func getNickname() -> String {
        return UserDefaultsManager.shared.userInfo.nickname + "님 이름 정하기"
    }
    
    private func setNickname(_ text: String) {
        var data = UserDefaultsManager.shared.userInfo
        data.nickname = text
        UserDefaultsManager.shared.userInfo = data
    }
    
}
