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
import MBProgressHUD
extension Observable where Element : Moya.Response {
    func showErrorHUD() -> Observable<Element> {
        let reportingVC = UIApplication.bl_currentViewController()
        return self.do(onNext: {(response) in
            if (!(200...210 ~= response.statusCode)) {
                
                LogError(response.statusCode)
            }
        }, onError: {(e) in
            guard let error = e as? MoyaError else { throw e }
            guard reportingVC == UIApplication.bl_currentViewController() else {return}
            if let message = error.response?.message, message.length > 0{
                UIAlertController.show(title: message)
            } else if let message = error.response?.responseJSON.stringValue{
                var  title = String(describing: error.response?.statusCode)
                if message.length > 0 {
                    title += "\n"
                    title += message
                }
                UIAlertController.show(title: title)
            }
//            LogError( ?? error)
//            LogError(error.response?.statusCode)
        })
    }
    
    func showLoadingToast(on view:UIView) -> Observable<Element> {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.backgroundView.color = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
        return  self.do(onNext: {(response) in
                MBProgressHUD.hide(for: view, animated: true)
                }, onError: {(e) in
                MBProgressHUD.hide(for: view, animated: true)
            })
    }
    
    func showHUD(on view:UIView) -> Observable<Element> {
        return self.showLoadingToast(on: view).showErrorHUD()
    }
}

extension UIAlertController {
    class func show(title:String, time:TimeInterval = 2, completion:@escaping (() -> Void) = {}) {
        let vc = UIAlertController.init(title: title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        vc.show()
        _ = Observable<Int>.timer(0, period:1, scheduler: MainScheduler.instance).take(Int(time)).subscribe(onNext: {x in
                vc.dismiss(animated: true, completion: completion)
        })
    }
    func show(){
        UIApplication.bl_currentViewController().present(self, animated: true, completion: nil)
    }
}
