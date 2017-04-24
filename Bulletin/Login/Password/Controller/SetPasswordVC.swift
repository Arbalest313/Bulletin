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
        _ = APIProvider.request(.changePassword(password: passwordCell.textFld.text!))
            .filterSuccessfulStatusCodes()
            .showErrorHUD()
            .subscribe(onNext: { (response) in
                self.dismiss(animated: true, completion: nil)
            })

    }
    override func prepareBinding() {
        Observable.of(passwordCell.textFld.rx.text, confirmCell.textFld.rx.text).merge().map {[unowned self] (x) -> Bool in
            if ((self.passwordCell.textFld.text?.length)! > 3 && self.passwordCell.textFld.text == self.confirmCell.textFld.text) {
                return true
            }
            return false
        }.distinctUntilChanged().subscribe(onNext:{[unowned self] enable in
                DispatchQueue.main.async {
                    self.rightBtn?.alpha = enable ? 1 : 0.5
                    self.rightBtn?.isEnabled = enable
                    self.rightBtn?.setNeedsDisplay()
                }
            }).disposed(by: disposeBag)
        
        
        confirmCell.textFld.rx.text.map {[unowned self] (x) -> Bool in
            if ((self.passwordCell.textFld.text?.length)! > 3 && (self.confirmCell.textFld.text?.length)! > 3
                && self.passwordCell.textFld.text != self.confirmCell.textFld.text) {
                return true
            }
            return false
        }.distinctUntilChanged().subscribe(onNext:{[unowned self] enable in
            self.confirmCell.textFld.placeholderActiveColor = enable ? Color.red.lighten1 :  ThemeConstant.defaultNavigationBarTintColor
            self.confirmCell.textFld.placeholder = enable ? "Not Matching" : "Confirm Password"
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
