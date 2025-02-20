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
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.isUserInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
    }
    
    override func configureView() {
        titleLabel.textColor = .labelText
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .labelBackground
        titleLabel.font = .boldSystemFont(ofSize: 13)
        
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.cornerRadius = 5
        titleLabel.layer.borderColor = UIColor.labelText.cgColor
        
        iconImageView.contentMode = .scaleAspectFit
    }
    
    override func configureHierarchy() {
        [iconImageView, titleLabel].forEach({ self.contentView.addSubview($0) })
    }
    
    override func configureLayout() {
        iconImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(1.5)
            make.top.horizontalEdges.equalToSuperview().inset(4)
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.horizontalEdges.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(4)
            make.top.equalTo(iconImageView.snp.bottom).offset(4)
        }
    }
    
    func configure(_ model: IconModel) {
        titleLabel.text = model.title
        iconImageView.image = UIImage(named: model.image)
    }
    
}
