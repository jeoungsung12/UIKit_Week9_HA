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
        let foodBtnTrigger: PublishSubject<String>
        let waterBtnTrigger: PublishSubject<String>
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
        let userInfoResult: BehaviorRelay<UserInfo> = BehaviorRelay(value: self.getUserInfo())
        
        input.foodBtnTrigger
            .bind(with: self) { owner, value in
                guard let value = Int(value) else {
                    userInfoResult.accept(owner.addFoodValue(1, userInfoResult))
                    owner.setUserInfo(userInfoResult.value)
                    return
                }
                userInfoResult.accept(owner.addFoodValue(value, userInfoResult))
                owner.setUserInfo(userInfoResult.value)
            }
            .disposed(by: disposeBag)
        
        input.waterBtnTrigger
            .bind(with: self) { owner, value in
                guard let value = Int(value) else {
                    userInfoResult.accept(owner.addWaterValue(1, userInfoResult))
                    owner.setUserInfo(userInfoResult.value)
                    return
                }
                userInfoResult.accept(owner.addWaterValue(value, userInfoResult))
                owner.setUserInfo(userInfoResult.value)
            }
            .disposed(by: disposeBag)
        
        return Output(
            userInfoResult: userInfoResult.asDriver()
        )
    }
    
}

extension MainViewModel {
    
    private func getUserInfo() -> UserInfo {
        let data = UserDefaultsManager.shared.userInfo
        return self.changeLevel(data)
    }
    
    private func setUserInfo(_ userInfoResult: UserInfo) {
        UserDefaultsManager.shared.userInfo = userInfoResult
    }
    
    private func changeLevel(_ userInfoResult: UserInfo) -> UserInfo  {
        var data = userInfoResult
        let level = Double(data.foodValue / 5) + Double(data.waterValue / 2)
        var levelValue = (Int(level / 10))
        levelValue = (levelValue == 0) ? 1 : levelValue
        data.levelValue = min(levelValue, 10)
        
        guard var iconData = data.iconData, let firstC = iconData.image.first, let num = Int(String(firstC)) else { return data }
        iconData.image = "\(num)-\(min(levelValue, 9))"
        data.iconData = iconData
        return data
    }
    
    private func addFoodValue(_ value: Int, _ userInfoResult: BehaviorRelay<UserInfo>) -> UserInfo {
        var data = userInfoResult.value
        data.foodValue = (value < 100) ? data.foodValue + value : data.foodValue
        data = changeLevel(data)
        return data
    }
    
    private func addWaterValue(_ value: Int, _ userInfoResult: BehaviorRelay<UserInfo>) -> UserInfo {
        var data = userInfoResult.value
        data.waterValue = (value < 50) ? data.waterValue + value : data.waterValue
        data = changeLevel(data)
        return data
    }
}
