//
//  CreatePostTipTypeCell.swift
//  Bulletin
//
//  Created by huangyuan on 21/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import Material
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift
class CreatePostTipTypeCell: TextInputCell, BaseTableCell {

    let inputPicker = SimplePicker().then { (x) in
        x.sourceData = ["Tip", "Tip2", "Other"]
    }
     func handle(rowData: RowData) {
        guard let data = rowData.data as? CreatePostVM else {
            fatalError("rowData.data as CreatePostVM failed")
        }
        textFld.inputView = inputPicker.pickerView
        inputPicker.didSelectRow = {[unowned self] value in
            self.textFld.text = value
        }
        _ = textFld.rx.text.orEmpty.takeUntil(prepareForReueseObserver()).subscribe(onNext: { (x) in
            data.postType.value = x
        })
    }
    
    dynamic func doneClicked() {
        inputPicker.pickerView(inputPicker.pickerView, didSelectRow: inputPicker.pickerView.selectedRow(inComponent: 0), inComponent: 0)
        textFld.resignFirstResponder()
        endEditing(true)
    }
    
    override func viewSetup() {
        addSubview(textFld)
        textFld.rx.text.orEmpty.map { (x) -> Bool in
            return x.length > 0
            }.distinctUntilChanged()
            .subscribe(onNext: {[unowned self] (hasTitle) in
                self.textFld.placeholder = !hasTitle ? "Picker your  tips" : "In Return"
            }).disposed(by: disposeBag)
        textFld.addDoneOnKeyboardWithTarget(self, action: #selector(CreatePostTipTypeCell.doneClicked))
        
        textFld.snp.makeConstraints { (x) in
            x.top.equalToSuperview().offset(12 + 15)
            x.bottom.equalToSuperview()
            x.left.equalToSuperview().offset(15)
            x.right.equalToSuperview().offset(-15)
            x.height.equalTo(44)
        }
        backgroundColor = UIColor.white
    }

}
