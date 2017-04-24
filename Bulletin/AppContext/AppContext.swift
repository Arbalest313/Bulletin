//
//  AppContext.swift
//  Bulletin
//
//  Created by huangyuan on 13/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit

class AppContext: NSObject {
    static let shared = AppContext()
    

}


class LoginContext: NSObject {
    static var shared = UserM()
    
    class func isLogined() -> Bool {
        return shared.isLogined()
    }
    
    
    class func checkLogin(complete:((Void) -> Void)?) {
        if LoginContext.isLogined() {
            complete?()
            return
        }
        let loginNavi = BaseNavigationController(rootViewController: LoginVC())
        _ = loginNavi.rx.deallocating.subscribe(onNext: { tuple in
                complete?()
        })
        UIApplication.bl_currentViewController().present(loginNavi, animated: true, completion: nil)
    }
}
