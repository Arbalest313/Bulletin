//
//  CreatePostTitleCell.swift
//  Bulletin
//
//  Created by huangyuan on 21/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class CreatePostTitleCell: TextInputCell, BaseTableCell {
    func handle(rowData: RowData) {
        guard let data = rowData.data as? CreatePostVM else {
            fatalError("rowData.data as CreatePostVM failed")
        }
        _ = textFld.rx.text.orEmpty.takeUntil(prepareForReueseObserver()).subscribe(onNext: { (x) in
            data.title.value = x
        })
    }
    
    override func viewSetup() {
        addSubview(textFld)
        textFld.rx.text.orEmpty.map { (x) -> Bool in
            return x.length > 0
            }.distinctUntilChanged()
            .subscribe(onNext: {[unowned self] (hasTitle) in
                self.textFld.placeholder = !hasTitle ? "Wirte your request title here" : "Title"
            }).disposed(by: disposeBag)
        

        textFld.snp.makeConstraints { (x) in
            x.top.equalToSuperview().offset(12 + 15)
            x.bottom.equalToSuperview()
            x.left.equalToSuperview().offset(15)
            x.right.equalToSuperview().offset(-15)
            x.height.equalTo(44)
        }
        backgroundColor = UIColor.white
    }
}
