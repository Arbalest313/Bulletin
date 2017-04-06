//
//  AuthPlugin.swift
//  Bulletin
//
//  Created by huangyuan on 06/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import Moya

struct AuthPlugin: PluginType {
    let tokenClosure: () -> String?
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let token = tokenClosure() else {
            return request
        }
        var request = request
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        return request
    }
}
