//
//  BaseCollectionViewCell.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import UIKit

protocol ReusableIdentifier {}
extension ReusableIdentifier {
    static var id: String {
        return String(describing: self)
    }
}

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureHierarchy()
        configureLayout()
        setBinding()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() { }
    func configureHierarchy() { }
    func configureLayout() { }
    func setBinding() { }
    
}

