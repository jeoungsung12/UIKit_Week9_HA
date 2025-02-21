//
//  MainViewModel.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import UIKit
import RxSwift
import RxCocoa

struct UserInfo: Codable {
    var iconData: IconModel?
    var nickname: String
    var foodValue: Int
    var waterValue: Int
    var levelValue: Int
    
    var statusValue: String {
        return "LV\(levelValue) • 밥알\(foodValue)개 • 물방울\(waterValue)개"
    }
}

final class MainViewModel: BaseViewModel {
    private var disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        let userInfoResult: Driver<UserInfo>
    }
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension MainViewModel {
    
    func transform(_ input: Input) -> Output {
        let userInfoResult = BehaviorRelay(value: self.getUserInfo())
        
        return Output(
            userInfoResult: userInfoResult.asDriver()
        )
    }
    
    private func getUserInfo() -> UserInfo {
        return UserDefaultsManager.shared.userInfo
    }
    
}
