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
        activityIndicator.color = .label
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        flipLogo()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SplashView {
    func setupUI() {
        backgroundColor = .systemBackground
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
    
    func flipLogo() {
        UIView.animateKeyframes(withDuration: 3, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.logoImageView.layer.transform = CATransform3DMakeRotation(.pi, 0, 1, 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.logoImageView.layer.transform = CATransform3DMakeRotation(2 * .pi, 0, 1, 0)
            }
        }
    }
}
