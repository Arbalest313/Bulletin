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
        if let t = target as? LoginAPI, t.path == LoginAPI.login(username: "",password: "").path {
            let client = "Gwy5Zzgml6C2OBdp1E74X4GRajxrAHIqZ0lGNUvz"
            let sercet = "iAcj0S77EzeKBpCGFKs7QZdrT1v6zU3N03oHrRm8bUqFfwebv5bnM08cTqyfT5qJ2XcM61qi2D9nE8dhO1A28KO6tooXLTGej89ZZ7gXjBEJ3IXCeV4DK4I6jnpAEYz8"
            let base64 = "\(client):\(sercet)".toBase64()
            request.addValue("Basic \(base64)", forHTTPHeaderField:"Authorization")
        } else {
            request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
