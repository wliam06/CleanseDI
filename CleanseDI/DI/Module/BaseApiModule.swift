//
//  BaseApiModule.swift
//  CleanseDI
//
//  Created by William Hendra on 05/05/21.
//

import Foundation
import Cleanse

struct BaseApiURL: Tag {
    typealias Element = URL
}

struct BaseApiURLModule: Module {
    
    static func configure(binder: Binder<Unscoped>) {
        binder
            .bind(URL.self)
            .tagged(with: BaseApiURL.self)
            .to(value: URL(string: "https://hacker-news.firebaseio.com/v0")!)
    }
}
