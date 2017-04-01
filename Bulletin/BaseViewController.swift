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
class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.backgroundColor = ThemeConstant.defaultgray
        navigationController?.navigationBar.isTranslucent = false
        automaticallyAdjustsScrollViewInsets = false
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

