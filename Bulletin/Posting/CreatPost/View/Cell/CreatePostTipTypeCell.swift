//
//  CreatePostTipTypeCell.swift
//  Bulletin
//
//  Created by huangyuan on 21/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit

class CreatePostTipTypeCell: UIView, BaseTableCell {

//    let inputPicker : SimplePickere
    override func handle(rowData: RowData) {
        guard let data = rowData.data as? CreatePostVM else {
            fatalError("rowData.data as CreatePostVM failed")
        }
//        _ = data.postType.asObservable().takeUntild(prepareForReueseObserver()).bindTo(textFld.rx.text)
    }
    
}
