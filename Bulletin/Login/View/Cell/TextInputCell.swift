//
//  TextInputCell.swift
//  Bulletin
//
//  Created by huangyuan on 01/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import SnapKit

class TextInputCell: UITableViewCell {
    
    let textFld : UITextField = {
        let fld = UITextField()
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
            x.top.equalToSuperview()
            x.bottom.equalToSuperview()
            x.left.equalToSuperview().offset(17)
            x.right.equalToSuperview().offset(-15)
            x.height.equalTo(44)
        }
        backgroundColor = UIColor.white
    }
}
