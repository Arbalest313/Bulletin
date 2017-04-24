//
//  UIView+Ext.swift
//  Bulletin
//
//  Created by huangyuan on 01/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit

extension UIView {
    var bl_cornerRadius : CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}


extension UIButton {
    var bl_title: String {
        get {
            return title(for: .normal) ?? ""
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
    
    var bl_titleColor: UIColor? {
        get {
            return titleColor(for: .normal)
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }

}

extension UIApplication {
    class func bl_currentViewController() -> UIViewController {
        if let vc = UIApplication.shared.keyWindow?.currentViewController() {
            return vc
        }
        return UIViewController()
    }
}
