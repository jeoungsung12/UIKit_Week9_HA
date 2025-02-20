//
//  BaseViewModel.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
