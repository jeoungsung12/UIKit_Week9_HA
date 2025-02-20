//
//  DialogViewModel.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa

final class DialogViewModel: BaseViewModel {
    private var disposeBag = DisposeBag()
    private(set) var descriptionText: String = "키는 100km\n몸무게는 150톤이에용\n성격은 화끈하고 날라다닙니당~!\n열심히 잘 먹고 잘 클 자신은\n있답니당 방실방실!"
    
    struct Input {
        let startBtnTrigger: ControlEvent<Void>
        let iconImageTrigger: PublishSubject<IconModel>
    }
    
    struct Output {
//        let startBtnResult: Driver<Void>
        let iconResult: Driver<IconModel>
    }
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension DialogViewModel {
    
    func transform(_ input: Input) -> Output {
        input.startBtnTrigger
            .bind(with: self) { owner, _ in
                
            }
            .disposed(by: disposeBag)
        
        
        let icon: BehaviorRelay<IconModel> = BehaviorRelay(value: IconModel(image: "", title: ""))
        input.iconImageTrigger
            .bind(with: self, onNext: { owner, model in
                icon.accept(model)
            })
            .disposed(by: disposeBag)
        
        return Output(
            iconResult: icon.asDriver()
        )
    }
    
}
