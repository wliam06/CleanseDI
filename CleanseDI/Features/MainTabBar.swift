//
//  MainTabBar.swift
//  CleanseDI
//
//  Created by William Hendra on 05/05/21.
//

import UIKit
import Cleanse
import RxSwift

class MainTabBar: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("MainTabBarViewController init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainTabBar {
    struct Module: Cleanse.Module {
        static func configure(binder: UnscopedBinder) {
            binder
                .bind(MainTabBar.self)
                .to(factory: { (viewControllers: [UIViewController]) -> MainTabBar in
                    let mainTabBarViewController = MainTabBar.init()
                    mainTabBarViewController.viewControllers = viewControllers
                    return mainTabBarViewController
                })
            binder
                .bind()
                .tagged(with: UIViewController.Root.self)
                .to { $0 as MainTabBar }
        }
    }
}
