//
//  TextInputCell.swift
//  Bulletin
//
//  Created by huangyuan on 01/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import SnapKit
import Material
class TextInputCell: UITableViewCell {
    
    let textFld : TextField = {
        let fld = TextField()
        fld.placeholderVerticalOffset = 15
        fld.contentMode = .bottom
        fld.dividerActiveColor = ThemeConstant.defaultNavigationBarTintColor
        fld.placeholderActiveColor = ThemeConstant.defaultNavigationBarTintColor
        fld.autocapitalizationType = .none
        return fld
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style,reuseIdentifier:reuseIdentifier)
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
}

extension TextInputCell {
    func viewSetup() {
        addSubview(textFld)
        textFld.snp.makeConstraints { (x) in
            x.top.equalToSuperview().offset(12)
            x.bottom.equalToSuperview()
            x.left.equalToSuperview().offset(17)
            x.right.equalToSuperview()
            x.height.equalTo(44)
        }
        backgroundColor = UIColor.white
        //isUserInteractionEnabled = true
        //textFld.isUserInteractionEnabled = true
    }
}
