//
//  SplashViewController.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit
import RxSwift

final class SplashViewController: BaseViewController<SplashViewModel> {
    private lazy var contentView = SplashView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
}

private extension SplashViewController {
    func bindViewModel() {
        viewModel.isLoading
            .bind(to: contentView.loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
