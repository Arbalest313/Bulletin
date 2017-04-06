//
//  LoginUserDefualt.swift
//  Bulletin
//
//  Created by huangyuan on 06/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Moya
extension DefaultsKeys {
    static let apiCache = DefaultsKey<[String: Moya.Response?]>("apiCache")
}

extension UserDefaults {
    subscript(key: DefaultsKey<Moya.Response?>) -> Moya.Response? {
        get { return unarchive(key)}
        set { archive(key, newValue) }
    }
}
