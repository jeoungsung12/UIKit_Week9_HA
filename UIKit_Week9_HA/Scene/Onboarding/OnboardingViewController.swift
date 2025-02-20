//
//  OnboardingViewController.swift
//  UIKit_Week9_HA
//
//  Created by 정성윤 on 2/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class OnboardingViewController: BaseViewController {
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.setLayout())
    
    private let viewModel = OnboardingViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setBinding() {
        let input = OnboardingViewModel.Input()
        let output = viewModel.transform(input)
        
        output.iconResult
            .drive(collectionView.rx.items(cellIdentifier: OnboardingCollectionViewCell.id, cellType: OnboardingCollectionViewCell.self)) { item, element, cell in
                cell.configure(element)
            }
            .disposed(by: disposeBag)
        
        Observable.zip(
            collectionView.rx.modelSelected(IconModel.self),
            collectionView.rx.itemSelected
        )
        .map { $0.0 }
        .observe(on: MainScheduler.instance)
        .bind(with: self) { owner, model in
            if !model.image.contains("no") {
                let vc = DialogViewController()
                vc.input.iconImageTrigger.onNext(model)
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true)
            }
        }
        .disposed(by: disposeBag)
    }
    
    override func configureView() {
        setNavigation("다마고치 선택하기")
        self.view.backgroundColor = .background
        configureCollectionView()
    }
    
    override func configureHierarchy() {
        self.view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    deinit {
        print(#function, self)
    }
    
}

extension OnboardingViewController {
    
    private func configureCollectionView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .background
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.id)
    }
    
    private func setLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 24
        let width = (UIScreen.main.bounds.width - (spacing * 4)) / 3
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: width, height: width + 50)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }
    
}
