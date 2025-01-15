//
//  SplashViewController.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit
import RxSwift

final class SplashViewController: BaseViewController<SplashViewModel> {
    private let contentView = SplashView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

private extension SplashViewController {
    func bind() {
        viewModel.isLoading
            .bind(to: contentView.loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
