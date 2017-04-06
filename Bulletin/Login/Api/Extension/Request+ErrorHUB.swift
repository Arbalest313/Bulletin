//
//  Request+ErrorHUB.swift
//  Bulletin
//
//  Created by huangyuan on 06/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import RxSwift
import Moya
extension Observable where Element : Moya.Response {
    func showErrorHUD() -> Observable<Element> {
        return self.do(onNext: {(response) in
            if (!(200...210 ~= response.statusCode)) {
                LogError(response.message)
            }
        }, onError: {(e) in
            guard let error = e as? MoyaError else { throw e }
            LogError(error.response?.message ?? error)
        })
    }
}
