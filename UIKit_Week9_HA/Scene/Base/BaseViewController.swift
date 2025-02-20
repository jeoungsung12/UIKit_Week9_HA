//
//  BaseViewController.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
        setBinding()
    }
    
    func configureView() { }
    func configureHierarchy() { }
    func configureLayout() { }
    func setBinding() { }
}
