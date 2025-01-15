//
//  SplashView.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit
import RxCocoa
import SnapKit

final class SplashView: UIView {
    enum Constants {
        static let logoImageWidth = 356
        static let logoImageHeight = 156
        static let loadingIndicatorTopPadding = 16
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(resource: ImageResource.ugLogo)
        return imageView
    }()
    
    private(set) lazy var loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemYellow
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SplashView {
    func setupUI() {
        backgroundColor = .white
        addSubview(logoImageView)
        addSubview(loadingIndicator)
        configureLogoImageView()
        configureLoadingIndicator()
    }
    
    func configureLogoImageView() {
        logoImageView.snp.makeConstraints {
            $0.center.equalTo(self)
            $0.width.equalTo(Constants.logoImageWidth)
            $0.height.equalTo(Constants.logoImageHeight)
        }
    }
    
    func configureLoadingIndicator() {
        loadingIndicator.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(logoImageView.snp.bottom).offset(Constants.loadingIndicatorTopPadding)
        }
    }
}
