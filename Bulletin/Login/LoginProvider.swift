//
//  LoginProvider.swift
//  Bulletin
//
//  Created by huangyuan on 06/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import Moya

let APIProvider = RxMoyaProvider<LoginAPI>(plugins:[NetworkLoggerPlugin(),AuthPlugin(tokenClosure:{LoginContext.shared.token})])

enum LoginAPI {
    case login(username:String, password:String)
    case verifyAccount(username:String, code:String)
    case changePassword(password:String)
    case requestCode(username:String)
}

// MARK: - TargetType Protocol Implementation
extension LoginAPI: TargetType{

    /// The target's base `URL`.
    var baseURL: URL {
        return URL(string: "http://efoodvan.herokuapp.com")!
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .login:
            return "/o/token/"
        case .verifyAccount:
            return "/user-api/verifyAccount/"
        case .changePassword:
            return "/user-api/changePass/"
        case .requestCode:
            return "/user-api/requestCode/"
        default:
            return ""
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .login, .verifyAccount, .requestCode:
            return .post
        case .changePassword:
            return .put
        }
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        var param : [String: Any] = [:]
        switch self {
        case .login(let username, let password):
            param["username"] = username
            if password == "test"
            {
                param["password"] = password
            } else {
                param["password"] = password.md5()
            }
            param["grant_type"] = "password"
        case .verifyAccount(let username, let code):
            param["username"] = username
            param["code"] = code
        case .changePassword(let password):
            param["password"] = password.md5()
        case .requestCode(let username):
            param["username"] = username
            param["password"] = username.md5()
        }
        return param
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
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







