//
//  BaseModel.swift
//  Bulletin
//
//  Created by huangyuan on 20/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import RxSwift
class BaseModel: NSObject {
    let disposeBag = DisposeBag()

    required override init() {
        super.init()
        prepareInit()
    }
    
    func prepareInit() {
    }
    
}
