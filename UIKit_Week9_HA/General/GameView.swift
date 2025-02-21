//
//  GameView.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import UIKit
import SnapKit

final class GameView: BaseView {
    private let foodStackView = UIStackView()
    private let waterStackView = UIStackView()
    
    let foodTextField = UITextField()
    let foodButton = UIButton()
    let waterTextField = UITextField()
    let waterButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureView() {
        [foodStackView, waterStackView].forEach({
            $0.spacing = 10
            $0.axis = .horizontal
            $0.alignment = .center
            $0.distribution = .fill
        })
        foodTextField.placeholder = "밥주세용"
        waterTextField.placeholder = "물주세용"
        [foodTextField, waterTextField].forEach({
            $0.textColor = .labelText
            $0.textAlignment = .center
            $0.keyboardType = .numberPad
            $0.font = .boldSystemFont(ofSize: 13)
            
            let underlineView = UIView()
            underlineView.backgroundColor = .labelText
            $0.addSubview(underlineView)
            underlineView.snp.makeConstraints { make in
                make.leading.trailing.bottom.equalToSuperview()
                make.height.equalTo(1)
            }
        })
        
        configureButton(foodButton, "밥먹기", "drop.circle")
        configureButton(waterButton, "물먹기", "leaf.circle")
        [foodButton, waterButton].forEach({
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.labelText.cgColor
            $0.setTitleColor(.labelText, for: .normal)
        })
    }
    
    override func configureHierarchy() {
        [foodTextField, foodButton]
            .forEach({ foodStackView.addArrangedSubview($0) })
        [waterTextField, waterButton]
            .forEach({ waterStackView.addArrangedSubview($0) })
        self.addSubview(foodStackView)
        self.addSubview(waterStackView)
    }
    
    override func configureLayout() {
        foodButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3)
        }
        waterButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3)
        }
        
        foodStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.horizontalEdges.equalToSuperview()
        }
        waterStackView.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(foodStackView.snp.bottom).offset(12)
        }
    }
    
}

extension GameView {
    
    private func configureButton(_ button: UIButton,_ title: String,_ image: String) {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .labelText
        config.image = UIImage(systemName: image)
        config.title = title
        config.imagePlacement = .leading
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { input in
            var output = input
            output.font = .boldSystemFont(ofSize: 12)
            return output
        }
        button.configuration = config
    }
}
