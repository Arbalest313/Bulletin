//
//  ViewController.swift
//  Bulletin
//
//  Created by huangyuan on 30/03/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Material
class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ThemeConstant.defaultgray
        navigationController?.navigationBar.isTranslucent = false
        automaticallyAdjustsScrollViewInsets = false
        prepareView()
        prepareBinding()
        if (navigationController?.viewControllers.count) ?? 0 > 1 {
            prepareLeftView()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension BaseViewController {
    func rightBarItemClick() {}
    func leftBarItemClick() {
        _ = navigationController?.popViewController(animated: true)
    }
    func creatBarItemRight(title: String) -> UIButton {
        let btn = FlatButton()
        btn.bl_title = title
        btn.pulseAnimation = .centerRadialBeyondBounds
        btn.titleLabel?.font = ThemeConstant.defaultFont(15)
        btn.bl_titleColor = UIColor.white
        btn.addTarget(self, action: #selector(rightBarItemClick), for: .touchUpInside)
        btn.sizeToFit()
        let right = UIBarButtonItem(customView: btn)
        navigationItem.rightBarButtonItem = right
        return btn
    }
    
    func creatBarItemRight(image: String) {
        let btn = FlatButton()
        btn.image = UIImage(named: image)
        btn.pulseAnimation = .centerWithBacking
        btn.titleLabel?.font = ThemeConstant.defaultFont(13)
        btn.bl_titleColor = UIColor.white
        btn.addTarget(self, action: #selector(rightBarItemClick), for: .touchUpInside)
        let right = UIBarButtonItem(customView: btn)
        navigationItem.rightBarButtonItem = right
    }
}

extension BaseViewController {
    func prepareView() {
    
    }
    func prepareBinding (){
    
    }
    fileprivate func prepareLeftView (){
        let btn = IconButton()
        btn.image = UIImage(named: "nav_back")
        btn.pulseAnimation = .centerRadialBeyondBounds
        btn.addTarget(self, action: #selector(leftBarItemClick), for: .touchUpInside)
        btn.sizeToFit()
        let right = UIBarButtonItem(customView: btn)
        navigationItem.leftBarButtonItem = right
    }
}
