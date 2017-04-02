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
    
}

extension TextInputCell {
    func viewSetup() {
        contentView.addSubview(textFld)
        contentView.snp.makeConstraints { (x) in
            x.edges.equalToSuperview()
        }
        textFld.snp.makeConstraints { (x) in
            x.top.equalToSuperview().offset(12)
            x.bottom.equalToSuperview()
            x.left.equalToSuperview().offset(17)
            x.right.equalToSuperview()
            x.height.equalTo(44)
        }
        selectionStyle = .none
        backgroundColor = UIColor.white
        isUserInteractionEnabled = true
    }
}