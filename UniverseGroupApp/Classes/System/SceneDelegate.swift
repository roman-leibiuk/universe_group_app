//
//  SceneDelegate.swift
//  UniverseGroupApp
//
//  Created by Roman Leibiuk on 13.01.2025.
//

import UIKit

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    private(set) static var shared: SceneDelegate?
    private var appCoordinator: AppCoordinator?
    
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        Self.shared = self
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let container = AppContainerImpl()
        window = .init(windowScene: windowScene)
        appCoordinator = .init(window: window, container: container)
        appCoordinator?.start()
    }
}
