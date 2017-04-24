//
//  CreatePostDescriptionsCell.swift
//  Bulletin
//
//  Created by huangyuan on 21/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import Material
import RxSwift
import RxCocoa
class CreatePostDescriptionsCell: UITableViewCell, BaseTableCell {
    let textV : TextView = {
        let fld = TextView()
//        fld.placeholderVerticalOffset = 15
//        fld.contentMode = .bottom
//        fld.dividerActiveColor = ThemeConstant.defaultNavigationBarTintColor
//        fld.placeholderActiveColor = ThemeConstant.defaultNavigationBarTintColor
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

    func handle(rowData: RowData) {
        guard let data = rowData.data as? CreatePostVM else {
            fatalError("rowData.data as CreatePostVM failed")
        }
        textV.placeholder = "Your descriptions"
        _ = data.descriptions.asObservable().takeUntil(prepareForReueseObserver()).bindTo(textV.rx.text)
    }
    
    func viewSetup() {
        addSubview(textV)
        textV.snp.makeConstraints { (x) in
            x.top.equalToSuperview().offset(12 + 15)
            x.bottom.equalToSuperview()
            x.left.equalToSuperview().offset(15)
            x.right.equalToSuperview().offset(-15)
            x.height.equalTo(44 * 3)
        }
        backgroundColor = UIColor.white
        
    }
}
