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
