//
//  AlertPlugin.swift
//  Bulletin
//
//  Created by huangyuan on 06/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import Moya
import Result

class RequestAlertPlugin: PluginType {
    
    /// Called immediately before a request is sent over the network (or stubbed).
    func willSend(_ request: RequestType, target: TargetType) {
    }
    
    /// Called after a response has been received, but before the MoyaProvider has invoked its completion handler.
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        //guard target.needsErrorMessage else {
          //  return
        //}
        switch result {
        case .success(let response):
            if (!(200...210 ~= response.statusCode)) {
                LogError(response.message)
            }
            break
        case .failure(let error):
            LogError(error.response?.message)
        }
    
    }
}
