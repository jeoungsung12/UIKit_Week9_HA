//
//  SettingViewModel.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SettingViewModel: BaseViewModel {
    private var disposeBag = DisposeBag()
    
    enum SettingType: Int, CaseIterable {
        case setName
        case changeProfile
        case reload
        
        var title: String {
            switch self {
            case .setName:
                "내 이름 설정하기"
            case .changeProfile:
                "다마고치 변경하기"
            case .reload:
                "데이터 초기화"
            }
        }
        
        var image: String {
            switch self {
            case .setName:
                "pencil"
            case .changeProfile:
                "moon.fill"
            case .reload:
                "arrow.clockwise"
            }
        }
    }
    
    struct Input {
        
    }
    
    struct Output {
        let settingList: BehaviorRelay<[SettingType]> = BehaviorRelay(value: SettingType.allCases)
    }
    
}

extension SettingViewModel {
    
    func transform(_ input: Input) -> Output {
        
        return Output()
    }
}
