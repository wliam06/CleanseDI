//
//  SceneDelegate.swift
//  CleanseDI
//
//  Created by William Hendra on 05/05/21.
//

import UIKit
import Cleanse
import AlamofireNetworkActivityLogger

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var componentFactory: ComponentFactory<MainComponent>?
    var componentFactoryInjector: PropertyInjector<SceneDelegate>?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupNetwork()
        setupApplication(windowScene: windowScene)
        // Make sure everything went according to plan
//        precondition(window != nil)
        window?.makeKeyAndVisible()
    }
}

private extension SceneDelegate {
    func setupNetwork() {
        NetworkActivityLogger.shared.level = .info
        NetworkActivityLogger.shared.startLogging()
    }

    func setupApplication(windowScene: UIWindowScene) {
        componentFactory = try? ComponentFactory.of(MainComponent.self)
        componentFactoryInjector = componentFactory?.build(windowScene)
        componentFactoryInjector?.injectProperties(into: self)
    }
}

extension SceneDelegate {
    func injectProperties(_ window: UIWindow) {
        self.window = window
    }
}
