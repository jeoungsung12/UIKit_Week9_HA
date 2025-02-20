//
//  MainViewModel.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import UIKit
import RxSwift
import RxCocoa

final class MainViewModel: BaseViewModel {
    private var disposeBag = DisposeBag()
    
    struct Input {
        
    }
    
    struct Output {
        
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
        
        
        return Output()
    }
    
}
