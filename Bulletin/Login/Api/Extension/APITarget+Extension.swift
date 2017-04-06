//
//  APITarget+Extension.swift
//  Bulletin
//
//  Created by huangyuan on 06/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import RxSwift
import RxCocoa
import  SwiftyUserDefaults
extension  TargetType {
    var useOfflineCache : Bool { return false}
}

extension TargetType  {
    var cacheKey : String {
        var decode = ""
        if let jsonData = try? JSONSerialization.data(withJSONObject: self.parameters ?? [:], options: .prettyPrinted) {
             decode = String.init(data: jsonData, encoding: .utf8) ?? ""
        }

        return self.baseURL.absoluteString + self.path + decode
    }
}



extension  RxMoyaProvider {
      open func requesta(_ token: Target) -> Observable<Response> {
        return Observable.create { observer in
            if token.useOfflineCache {
                //let key = target.cacheKey
                //let dic = Defaults[.apiCache]
                //if let response = dic[key]  {
                  //  observer.onNext(response)
                //}
            }

            let cancellableToken = self.request(token) { result in
                switch result {
                case let .success(response):
                    observer.onNext(response)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
}
