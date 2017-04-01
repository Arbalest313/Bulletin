//
//  UITextField+Tools.swift
//  Tuhu
//
//  Created by huangyuan on 14/12/2016.
//  Copyright © 2016 Tuhu. All rights reserved.
//

import UIKit
import ObjectiveC

var AssociatedObjectHandle: UInt8 = 0

extension  UITextField {
    var th_maxLength : Int {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? NSNumber else {
                return 0
            }
            return  value.intValue
        }
        
        set {
            if (objc_getAssociatedObject(self, &AssociatedObjectHandle) == nil) {
                self.addTarget(self, action: #selector(maxLengthAdjust), for: UIControlEvents.editingDidEnd)
            }
            objc_setAssociatedObject(self, &AssociatedObjectHandle, NSNumber(value:newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    @objc private func maxLengthAdjust (){
        guard let maxLength = objc_getAssociatedObject(self, &AssociatedObjectHandle) as? NSNumber else {
            return
        }
        if (text?.length)! > maxLength.intValue {
            let index = text!.index(text!.startIndex, offsetBy:maxLength.intValue)
            text = text?.substring(to: index)
        }
    }
    

}
