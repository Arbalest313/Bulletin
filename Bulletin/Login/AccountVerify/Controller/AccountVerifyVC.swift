//
//  AccountVerifyVC.swift
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

class AccountVerifyVC: BaseViewController {
    let codeCell = TextInputCell()
    let usernameCell = TextInputCell()

    let codeBtn = { () -> FlatButton in
        let btn = FlatButton()
        btn.bl_title = "Verify"
        btn.titleLabel?.font = ThemeConstant.defaultFont(18)
        btn.bl_titleColor = UIColor.white
        btn.bl_cornerRadius = 5
        btn.backgroundColor = ThemeConstant.defaultNavigationBarTintColor
        btn.pulseAnimation = .centerWithBacking
        btn.sizeToFit()
        btn.width = 108
        btn.y = -3
        return btn
    }()
    
    var nextBtn : UIButton? = nil
}

extension AccountVerifyVC {
    override func rightBarItemClick() {
        _ = APIProvider.request(.verifyAccount(username: usernameCell.textFld.text!, code: codeCell.textFld.text!))
            .filterSuccessfulStatusCodes()
            .showErrorHUD()
            .subscribe(onNext: { (response) in
                LoginContext.shared.token = response.dataJSON["access_token"].stringValue
                let vc = SetPasswordVC()
                vc.title = self.usernameCell.textFld.text!
                self.navigationController?.pushViewController(vc, animated: true)
            })
    }
    override func prepareBinding() {
        Observable.of(codeCell.textFld.rx.text,usernameCell.textFld.rx.text).merge().map {[unowned self] (x) -> Bool in
            if ((self.codeCell.textFld.text?.length)! > 3 && (self.usernameCell.textFld.text?.length)! > 4) {
                return true
            }
            return false
        }.distinctUntilChanged().subscribe(onNext:{[unowned self] enable in
            
                DispatchQueue.main.async {
                    self.nextBtn?.alpha = enable ? 1 : 0.5
                    self.nextBtn?.isEnabled = enable
                    self.nextBtn?.setNeedsDisplay()
                }
        }).disposed(by: disposeBag)
        
        
        usernameCell.textFld.rx.text.orEmpty.map { (x) -> Bool in
            if (x.length > 6) {
                return true
            }
            return false
            }.distinctUntilChanged().subscribe(onNext:{[unowned self] enable in
                LogDebug(enable)
                self.codeBtn.alpha = enable ? 1 : 0.5
                self.codeBtn.isEnabled = enable
            }).disposed(by: disposeBag)
        

        codeBtn.rx.tap.subscribe(onNext: {[unowned self] x in
            self.codeBtn.isEnabled = false
            self.codeBtn.alpha =  0.5
            _ = APIProvider.request(.requestCode(username:self.usernameCell.textFld.text!))
                .filterSuccessfulStatusCodes()
                .showErrorHUD()
                .subscribe(onNext: { (response) in
                    LogDebug(response.responseJSON)
                })

        }).disposed(by: disposeBag)
        
        let count = 5
        codeBtn.rx.tap.flatMap{ () -> Observable<Int> in
            return Observable<Int>.timer(0, period:1, scheduler: MainScheduler.instance).take(count)
        }.map { (x) -> Int in
            return count - x
        }.subscribe(onNext: {[unowned self] x in
            self.codeBtn.bl_title = "\(x)"
            if x == 1 {
                self.codeBtn.isEnabled = true
                self.codeBtn.alpha =  1
                self.codeBtn.bl_title = "Verify"
            }
        }).disposed(by: disposeBag)
    }

    override func prepareView() {
        view.addSubview(codeCell)
        view.addSubview(usernameCell)
        view.addSubview(codeBtn)
        
        nextBtn = creatBarItemRight(title: "Next")
        
        usernameCell.textFld.rightViewMode = .always
        let right = UIView(frame: CGRect(x: 0, y: 0, width: 108 + 15, height: codeBtn.height))
        right.isUserInteractionEnabled = true
        right.addSubview(codeBtn)
        usernameCell.textFld.rightView = right
        
        codeCell.textFld.placeholder = "Code"
        usernameCell.textFld.placeholder = "Email"
        usernameCell.textFld.clearButtonMode = .whileEditing
        usernameCell.snp.makeConstraints { (x) in
            x.left.width.equalToSuperview()
            //            x.height.equalTo(45)
            x.top.equalTo(self.view).offset(30)
        }
        
        codeCell.snp.makeConstraints { (x) in
            x.left.width.equalToSuperview()
            //            x.height.equalTo(45)
            x.top.equalTo(self.usernameCell.snp.bottom)
        }
    }

}
