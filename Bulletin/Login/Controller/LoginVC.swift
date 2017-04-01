//
//  LoginVC.swift
//  Bulletin
//
//  Created by huangyuan on 31/03/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//


import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginVC: BaseViewController {
    let passwordCell = TextInputCell()
    let usernameCell = TextInputCell()
    let line = { () -> UIView in
        let view = UIView()
        view.backgroundColor = ThemeConstant.defaultgray
        return view
    }()
    
    let loginBtn = { () -> UIButton in
        let btn = UIButton(type: .system)
        btn.bl_title = "Login"
        btn.titleLabel?.font = ThemeConstant.defaultFont(18)
        btn.bl_titleColor = UIColor.white
        btn.bl_cornerRadius = 5
        btn.backgroundColor = ThemeConstant.defaultNavigationBarTintColor
        btn.isEnabled = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bulletin"
        viewSetup()
        banding()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func viewSetup() {
        view.addSubview(passwordCell)
        view.addSubview(usernameCell)
        view.addSubview(line)
        view.addSubview(loginBtn)
        
        passwordCell.textFld.placeholder = "password"
        passwordCell.textFld.isSecureTextEntry = true
        usernameCell.textFld.placeholder = "username"
        usernameCell.snp.makeConstraints { (x) in
            x.left.width.equalToSuperview()
//            x.height.equalTo(45)
            x.top.equalTo(self.view).offset(30)
        }
        line.snp.makeConstraints { (x) in
            x.left.width.equalToSuperview().offset(15)
            x.height.equalTo(1)
            x.top.equalTo(self.usernameCell.snp.bottom).offset(-1)
        }
        passwordCell.snp.makeConstraints { (x) in
            x.left.width.equalToSuperview()
//            x.height.equalTo(45)
            x.top.equalTo(self.usernameCell.snp.bottom)
        }
        loginBtn.snp.makeConstraints { (x) in
            x.top.equalTo(self.passwordCell.snp.bottom).offset(30)
            x.left.equalToSuperview().offset(15)
            x.right.equalToSuperview().offset(-15)
            x.height.equalTo(57)
        }
    }
    
    
    func banding() {
        loginBtn.rx.controlEvent(.touchUpInside).subscribe(onNext:{e in
            }).disposed(by: disposeBag)
        Observable.of(passwordCell.textFld.rx.text,usernameCell.textFld.rx.text).merge().map { (x) -> Bool in
            if ((self.passwordCell.textFld.text?.length)! > 6 && (self.usernameCell.textFld.text?.length)! > 6) {
                return true
            }
            return false
        }.distinctUntilChanged().subscribe(onNext:{enable in
            LogDebug(enable)
            self.loginBtn.alpha = enable ? 1 : 0.5
            self.loginBtn.isEnabled = enable
        }).disposed(by: disposeBag)
        
        
    }
}
