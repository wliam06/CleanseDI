//
//  NetworkModule.swift
//  CleanseDI
//
//  Created by William Hendra on 05/05/21.
//

import Foundation
import Cleanse
import Alamofire

struct NetworkModule: Module {
    static func configure(binder: SingletonBinder) {
        binder
            .bind()
            .to(value: URLSessionConfiguration.ephemeral)
        binder
            .bind(ServerTrustManager?.self)
            .to(value: nil)
        binder
            .bind(SessionDelegate.self)
            .to(value: SessionDelegate())
        binder
            .bind()
            .to(factory: URLSession.init)
        binder
            .bind(Session.self)
            .to(value: Session.init())
    }
}
