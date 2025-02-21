//
//  OnboardingViewModel.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa

struct IconModel {
    let image: String
    let title: String
    
    var description: String {
        get {
            return "저는 \(title)입니다. " + "키는 100km 몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~! 열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!"
        }
    }
}

final class OnboardingViewModel: BaseViewModel {
    private var iconData: [IconModel] = [
        IconModel(image: "1-6", title: "따끔따끔 다마고치"),
        IconModel(image: "2-6", title: "방실방실 다마고치"),
        IconModel(image: "3-6", title: "반짝반짝 다마고치")
    ]

    struct Input {
        
    }
    
    struct Output {
        let iconResult: Driver<[IconModel]>
    }
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension OnboardingViewModel {
    
    func transform(_ input: Input) -> Output {
        iconData = iconData + Array(repeating: IconModel(image: "noImage", title: "준비중이에요"), count: 20)
        let iconResult: BehaviorRelay<[IconModel]> = BehaviorRelay(value: iconData)
        
        
        
        
        return Output(iconResult: iconResult.asDriver())
    }
    
}
