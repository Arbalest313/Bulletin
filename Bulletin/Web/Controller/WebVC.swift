//
//  WebVC.swift
//  Bulletin
//
//  Created by huangyuan on 02/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import WebKit
class WebVC: BaseViewController {
    fileprivate let webConfiguration = WKWebViewConfiguration()
    fileprivate lazy var webV : WKWebView = {[unowned self] in
        let view = WKWebView(frame: CGRect.zero, configuration: self.webConfiguration)
        view.uiDelegate = self
        return view
    }()
    
    var url : String = ""
}

extension WebVC: WKUIDelegate {

}
extension WebVC {
    override func prepareView() {
        view.addSubview(webV)
        guard let theUrl = URL(string: url) else {return}
        webV.load(URLRequest(url: theUrl))
        webV.snp.makeConstraints { (x) in
            x.edges.equalToSuperview()
        }
    }
    override func prepareBinding() {
        
    }
}
