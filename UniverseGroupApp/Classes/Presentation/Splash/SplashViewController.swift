//
//  SplashViewController.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit

final class SplashViewController: BaseViewController<SplashViewModel> {
    private let contentView = SplashView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getData()
    }
}
