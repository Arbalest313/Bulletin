//
//  LoginProvider.swift
//  Bulletin
//
//  Created by huangyuan on 06/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import Moya

let APIProvider = RxMoyaProvider<LoginAPI>(plugins:[NetworkLoggerPlugin(),AuthPlugin(tokenClosure:{"321"})])

enum LoginAPI {
    case login(username:String, password:String)
    case verifyAccount(username:String, code:String)
    case changePassword(password:String)
}

// MARK: - TargetType Protocol Implementation
extension LoginAPI: TargetType{

    /// The target's base `URL`.
    var baseURL: URL {
        return URL(string: "http://efoodvan.kerokuapp.com")!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .login:
            return "/user-api/login"
        case .verifyAccount:
            return "/user-api/verifyAccount"
        case .changePassword:
            return "/user-api/changePass"
        default:
            return ""
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .login, .verifyAccount, .changePassword:
            return .post
        default:
            return .get
        }
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        var param : [String: Any] = [:]
        switch self {
        case .login(let username, let password):
            param["username"] = username
            param["password"] = password
        case .verifyAccount(let username, let code):
            param["username"] = username
            param["code"] = code
        case .changePassword(let password):
            param["password"] = password
        }
        return param
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }

    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .request
    }
        
    var useOfflineCache: Bool {
        return false
    }
}







