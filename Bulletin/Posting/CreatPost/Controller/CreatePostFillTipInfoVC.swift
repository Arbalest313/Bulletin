//
//  FillTipInfoVC.swift
//  Bulletin
//
//  Created by huangyuan on 21/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

class CreatePostFillTipInfoVC: BaseViewController {
    var viewModel : CreatePostVM
    let tableV = UITableView().then {this in
        this.estimatedRowHeight = 400
        this.rowHeight = UITableViewAutomaticDimension
        this.separatorStyle = .none
        this.register(CreatePostTitleCell.self, forCellReuseIdentifier: "CreatePostTitleCell")
        this.register(CreatePostDescriptionsCell.self, forCellReuseIdentifier: "CreatePostDescriptionsCell")
    }
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RowData>>()
        
    var rightBarItemBtn = UIButton()
    init(viewModel: CreatePostVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = CreatePostVM()
        super.init(coder: aDecoder)
    }

}

extension CreatePostFillTipInfoVC {

    override func prepareView() {
        title = "Tips"
        rightBarItemBtn = creatBarItemRight(title: "Submit")
        view.addSubview(tableV)
        tableV.snp.makeConstraints { (x) in
            x.edges.equalToSuperview()
        }
    }
    
    override func prepareBinding() {
        let titleRow = RowData(reuseIdentifier: "CreatePostTitleCell", data: viewModel)
        let descriptionRow = RowData(reuseIdentifier: "CreatePostDescriptionsCell", data: viewModel)
        let rows = [titleRow, descriptionRow,]
        
        Observable.just([SectionModel(model:"", items:rows)])
            .bindTo(tableV.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        dataSource.configureCell = { (_, tv: UITableView, ip: IndexPath, item:RowData) in
            let cell = tv.dequeueReusableCell(withIdentifier: item.reuseIdentifier, for: ip)
            if let baseCell =  cell as? BaseTableCell {
                baseCell.handle(rowData: item)
            }
            return cell
        }
    }
}
