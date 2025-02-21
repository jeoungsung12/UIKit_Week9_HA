//
//  PopupViewModel.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol SelectedDelegate: AnyObject {
    func selectIcon()
}

final class PopupViewModel: BaseViewModel {
    private var disposeBag = DisposeBag()
    weak var delegate: SelectedDelegate?
    
    var iconModel: IconModel
    init(iconModel: IconModel) {
        self.iconModel = iconModel
    }
    
    struct Input {
        let startBtnTrigger: ControlEvent<Void>
    }
    
    struct Output {
        let startBtnResult: Driver<Void?>
        let iconResult: Driver<IconModel>
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension PopupViewModel {
    
    func transform(_ input: Input) -> Output {
        let icon: BehaviorRelay<IconModel> = BehaviorRelay(value: iconModel)
        
        let startResult: PublishSubject<Void?> = PublishSubject()
        input.startBtnTrigger
            .bind(with: self) { owner, _ in
                startResult.onNext(())
                owner.setIcon()
            }
            .disposed(by: disposeBag)
        
        return Output(
            startBtnResult: startResult.asDriver(onErrorJustReturn: nil),
            iconResult: icon.asDriver()
        )
    }
    
    private func setIcon() {
        var data = UserDefaultsManager.shared.userInfo
        data.iconData = self.iconModel
        UserDefaultsManager.shared.userInfo = data
    }
}
