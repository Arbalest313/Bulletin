//
//  SimplePicker.swift
//  Bulletin
//
//  Created by huangyuan on 24/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SimplePicker: NSObject,UIPickerViewDelegate, UIPickerViewDataSource {
    var sourceData : [String] = []
    
    lazy var pickerView = UIPickerView().then { (x) in
        x.delegate = self
        x.dataSource = self
    }
    
    var didSelectRow : ((String) -> Void)?
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sourceData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sourceData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelectRow?(sourceData[row] )
    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        <#code#>
//    }
}

class RxUIPickerViewDelegateProxy: DelegateProxy, UIPickerViewDelegate, UIPickerViewDataSource, DelegateProxyType {
    //We need a way to read the current delegate
    static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let mapView: UIPickerView = object as! UIPickerView
        return mapView.delegate
    }
    //We need a way to set the current delegate
    static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let mapView: UIPickerView = object as! UIPickerView
        mapView.delegate = delegate as? UIPickerViewDelegate
    }
    
    var sourceData : [String] = []
    
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sourceData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sourceData.count
    }
}

