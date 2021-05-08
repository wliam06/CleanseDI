//
//  CoreModule.swift
//  CleanseDI
//
//  Created by William Hendra on 05/05/21.
//

import Cleanse

struct CoreAppModule: Module {
    static func configure(binder: SingletonBinder) {
        binder.include(module: MainTabBar.Module.self)
        binder.include(module: TopStoriesViewController.Module.self)
        binder.include(module: StoryViewController.Module.self)
    }
}
