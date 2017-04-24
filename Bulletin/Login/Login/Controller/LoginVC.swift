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
import MBProgressHUD


class LoginVC: BaseViewController {
    
    fileprivate let passwordCell = TextInputCell()
    fileprivate let usernameCell = TextInputCell()
    
    fileprivate let termOfServiceBtn =  { () -> FlatButton in
        let btn = FlatButton()
        let text = "Term Of Services"
        let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, text.characters.count))
        titleString.addAttributes(characterAttributes: [CharacterAttribute.forgroundColor : Color.grey.base], range: NSMakeRange(0, text.characters.count))
        btn.setAttributedTitle(titleString, for: .normal)
        btn.titleLabel?.font = ThemeConstant.defaultFont(13)
        btn.pulseAnimation = .centerWithBacking
        return btn
    }()
    
    fileprivate let forgotBtn =  { () -> FlatButton in
        let btn = FlatButton()
        let text = "Forgot password?"
        let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, text.characters.count))
        titleString.addAttributes(characterAttributes: [CharacterAttribute.forgroundColor : Color.grey.base], range: NSMakeRange(0, text.characters.count))
        btn.setAttributedTitle(titleString, for: .normal)
        btn.pulseAnimation = .centerWithBacking
        btn.titleLabel?.font = ThemeConstant.defaultFont(13)
        return btn
    }()
    
    fileprivate let loginBtn = { () -> FlatButton in
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    override func rightBarItemClick() {
        let vc = AccountVerifyVC()
        vc.title = "Regist"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func leftBarItemClick() {
         dismiss(animated: true, completion: nil)
    }
    
    func viewSetup() {
        view.addSubview(passwordCell)
        view.addSubview(usernameCell)
        view.addSubview(loginBtn)
        view.addSubview(termOfServiceBtn)
        view.addSubview(forgotBtn)
        
        _ = creatBarItemRight(title: "Regist")
        prepareLeftView()
        
        passwordCell.textFld.placeholder = "Password"
        passwordCell.textFld.isVisibilityIconButtonEnabled = true
        usernameCell.textFld.placeholder = "Username"
        usernameCell.textFld.clearButtonMode = .whileEditing
        usernameCell.snp.makeConstraints { (x) in
            x.left.width.equalToSuperview()
            x.top.equalTo(self.view).offset(30)
        }
        
        passwordCell.snp.makeConstraints { (x) in
            x.left.width.equalToSuperview()
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

}

extension LoginVC {
    override func prepareBinding() {
        Observable.of(passwordCell.textFld.rx.text,usernameCell.textFld.rx.text).merge().map {[unowned self] (x) -> Bool in
            if ((self.passwordCell.textFld.text?.length)! > 3 && (self.usernameCell.textFld.text?.length)! > 3) {
                return true
            }
            return false
            }.distinctUntilChanged().subscribe(onNext:{[unowned self] enable in
                LogDebug(enable)
                self.loginBtn.alpha = enable ? 1 : 0.5
                self.loginBtn.isEnabled = enable
            }).disposed(by: disposeBag)
        
        termOfServiceBtn.rx.tap.subscribe (onNext:{[unowned self] (x) in
            let vc = WebVC()
            vc.url = "http://www.hyyy.me"
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        forgotBtn.rx.tap.subscribe (onNext:{[unowned self] (x) in
            let vc = AccountVerifyVC()
            vc.title = "Verify Account"
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        loginBtn.rx.tap.subscribe(onNext:{[unowned self] e in
            _ = APIProvider.request(.login(username: self.usernameCell.textFld.text!, password: self.passwordCell.textFld.text!))
                .filterSuccessfulStatusCodes()
                .showHUD(on: self.view)
                .subscribe(onNext: { (response) in
                LogDebug(response.responseJSON)
                    LoginContext.shared.token = response.responseJSON["access_token"].stringValue
                    self.navigationController?.dismiss(animated: true, completion: nil)
            })
        }).disposed(by: disposeBag)
    }

}
