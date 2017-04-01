//
//  UIView+Tools.swift
//  Tuhu
//
//  Created by huangyuan on 15/12/2016.
//  Copyright © 2016 Tuhu. All rights reserved.
//

import UIKit
var AssociatedObjectHandleLeft: UInt8 = 0
var AssociatedObjectHandleRight: UInt8 = 0
var AssociatedObjectHandleTop: UInt8 = 0
var AssociatedObjectHandleBottom: UInt8 = 0

extension UIButton {

    func th_enlargeTouchArea(left:Float, top:Float, right:Float, bottom:Float) {
        objc_setAssociatedObject(self, &AssociatedObjectHandleLeft, NSNumber(value:left), .OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &AssociatedObjectHandleRight, NSNumber(value:right), .OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &AssociatedObjectHandleTop, NSNumber(value:top), .OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &AssociatedObjectHandleBottom, NSNumber(value:bottom), .OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    func enlargedRect() -> CGRect{
        let topE = objc_getAssociatedObject(self, &AssociatedObjectHandleTop) as? NSNumber
        let bottomE = objc_getAssociatedObject(self, &AssociatedObjectHandleBottom) as? NSNumber
        let rightE = objc_getAssociatedObject(self, &AssociatedObjectHandleRight) as? NSNumber
        let leftE = objc_getAssociatedObject(self, &AssociatedObjectHandleLeft) as? NSNumber
        
        guard let top = topE?.floatValue, let right = rightE?.floatValue,
        let left = leftE?.floatValue, let bottom = bottomE?.floatValue else {
            return CGRect.zero
        }
        return CGRect(x: self.bounds.origin.x - left, y: self.bounds.origin.y - top, width: self.bounds.size.width + right + left, height: self.bounds.size.height + bottom + top)
    }
    
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let rect = enlargedRect()
        if rect.equalTo(CGRect.zero) {
            return super.hitTest(point, with: event)
        }
        return rect.contains(point) && isUserInteractionEnabled && !isHidden && alpha >= 0.01 ? self : nil
    }

}
