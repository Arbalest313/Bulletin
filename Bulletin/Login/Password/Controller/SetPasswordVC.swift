//
//  SetPasswordVC.swift
//  Bulletin
//
//  Created by huangyuan on 02/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Material

class SetPasswordVC: BaseViewController {
    let passwordCell = TextInputCell()
    let confirmCell = TextInputCell()
    var rightBtn : UIButton? = nil
    let phoneNumber = ""
}

extension SetPasswordVC {
    override func rightBarItemClick() {
        
    }
    override func prepareBinding() {
        Observable.of(passwordCell.textFld.rx.text,confirmCell.textFld.rx.text).merge().map { (x) -> Bool in
            if (self.passwordCell.textFld.text == self.confirmCell.textFld.text) {
                return true
            }
            return false
        }.distinctUntilChanged().subscribe(onNext:{enable in
                LogDebug(enable)
                DispatchQueue.main.async {
                    self.rightBtn?.alpha = enable ? 1 : 0.5
                    self.rightBtn?.isEnabled = enable
                    self.rightBtn?.setNeedsDisplay()
                }
            }).disposed(by: disposeBag)
    }
    
    override func prepareView() {
        view.addSubview(confirmCell)
        view.addSubview(passwordCell)
        
        rightBtn = creatBarItemRight(title: "Confirm")
        
        passwordCell.textFld.placeholder = "Password"
        confirmCell.textFld.placeholder = "Confirm Password"
        passwordCell.textFld.isVisibilityIconButtonEnabled = true
        confirmCell.textFld.isVisibilityIconButtonEnabled = true
        passwordCell.snp.makeConstraints { (x) in
            x.left.width.equalToSuperview()
            x.top.equalTo(self.view).offset(30)
        }
        
        confirmCell.snp.makeConstraints { (x) in
            x.left.width.equalToSuperview()
            x.top.equalTo(self.passwordCell.snp.bottom)
        }
    }

}