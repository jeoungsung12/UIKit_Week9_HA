//
//  UIViewController + Extension.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import UIKit

extension UIViewController {
    
    @objc func tapGesture(_ sender: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    func push(_ destination: UIViewController) {
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setRootView(_ rootVC: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
        window.rootViewController = rootVC
    }
    
    func setNavigation(_ title: String = "",_ backTitle: String = "",_ color: UIColor = .labelText, apperanceColor: UIColor = .background) {
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        self.navigationItem.title = title
        let back = UIBarButtonItem(title: backTitle, style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = back
        self.navigationItem.backBarButtonItem = back
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = apperanceColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
//        appearance.shadowColor = nil
        
        navigationBar.tintColor = color
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
}
