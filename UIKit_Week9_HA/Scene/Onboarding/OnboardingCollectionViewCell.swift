//
//  OnboardingCollectionViewCell.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class OnboardingCollectionViewCell: BaseCollectionViewCell, ReusableIdentifier {
    private let profileView = ProfileView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.isUserInteractionEnabled = true
    }
    
    override func configureHierarchy() {
        self.contentView.addSubview(profileView)
    }
    
    override func configureLayout() {
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(_ model: IconModel) {
        profileView.configure(model)
    }
    
}
