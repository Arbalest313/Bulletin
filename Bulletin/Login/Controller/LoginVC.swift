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
import Material
class LoginVC: BaseViewController {
    let passwordCell = TextInputCell()
    let usernameCell = TextInputCell()
    let line = { () -> UIView in
        let view = UIView()
        view.backgroundColor = ThemeConstant.defaultgray
        return view
    }()
    
    let termOfServiceBtn =  { () -> FlatButton in
        let btn = FlatButton()
        let text = "Term Of Services"
        let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, text.characters.count))
        btn.setAttributedTitle(titleString, for: .normal)
        btn.titleLabel?.font = ThemeConstant.defaultFont(13)
        btn.bl_titleColor = ThemeConstant.defaultNavigationBarTintColor
        btn.pulseAnimation = .centerWithBacking
        return btn
    }()
    
    let forgotBtn =  { () -> FlatButton in
        let btn = FlatButton()
        let text = "Forgot password?"
        let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, text.characters.count))
        btn.setAttributedTitle(titleString, for: .normal)
        btn.pulseAnimation = .centerWithBacking
        btn.titleLabel?.font = ThemeConstant.defaultFont(13)
        btn.bl_titleColor = ThemeConstant.defaultNavigationBarTintColor
        return btn
    }()
    
    let loginBtn = { () -> FlatButton in
        let btn = FlatButton()
        btn.bl_title = "Login"
        btn.titleLabel?.font = ThemeConstant.defaultFont(18)
        btn.bl_titleColor = UIColor.white
        btn.bl_cornerRadius = 5
        btn.backgroundColor = ThemeConstant.defaultNavigationBarTintColor
        btn.isEnabled = false
        btn.pulseAnimation = .centerWithBacking
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
        view.addSubview(loginBtn)
        view.addSubview(termOfServiceBtn)
        view.addSubview(forgotBtn)
        
        creatBarItemRight(title: "Regist")
        
        passwordCell.textFld.placeholder = "Password"
        passwordCell.textFld.isVisibilityIconButtonEnabled = true
        usernameCell.textFld.placeholder = "Username"
        usernameCell.textFld.clearButtonMode = .whileEditing
        usernameCell.snp.makeConstraints { (x) in
            x.left.width.equalToSuperview()
//            x.height.equalTo(45)
            x.top.equalTo(self.view).offset(30)
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
            x.height.equalTo(47)
        }
        
        forgotBtn.snp.makeConstraints { (x) in
            x.top.equalTo(self.loginBtn.snp.bottom).offset(18)
            x.right.equalToSuperview().offset(-15)
        }
        
        termOfServiceBtn.snp.makeConstraints { (x) in
            x.top.equalTo(self.loginBtn.snp.bottom).offset(18)
            x.left.equalToSuperview().offset(15)
        }
    }
    
    
    func banding() {
        loginBtn.rx.tap.subscribe(onNext:{e in
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
