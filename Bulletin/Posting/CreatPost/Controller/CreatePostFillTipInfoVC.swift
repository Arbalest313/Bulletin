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
        this.register(CreatePostTipTypeCell.self, forCellReuseIdentifier: "CreatePostTipTypeCell")
        this.register(CreatePostTipInfoCell.self, forCellReuseIdentifier: "CreatePostTipInfoCell")
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rightBarItemBtn.alpha = rightBarItemBtn.isEnabled ? 1 : 0.5
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
        let titleRow = RowData(reuseIdentifier: "CreatePostTipTypeCell", data: viewModel)
        let descriptionRow = RowData(reuseIdentifier: "CreatePostTipInfoCell", data: viewModel)
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
        
        viewModel.submitBtnEnable.asObservable().do(onNext: {[unowned self] enable in
            self.rightBarItemBtn.alpha = enable ? 1 : 0.5
        }).bindTo(rightBarItemBtn.rx.isEnabled).disposed(by: disposeBag)


        rightBarItemBtn.rx.tap.subscribe(onNext: {[unowned self] x in
            let viewModel = self.viewModel
            _ = APIProvider.request(.submitPost(title: viewModel.title.value,
                                                descriptions: viewModel.descriptions.value,
                                                type: viewModel.postType.value,
                                                extraInfo: viewModel.extraInfo.value))
                .filterSuccessfulStatusCodes()
                .showErrorHUD()
                .subscribe(onNext: { (response) in
                    LogDebug(response.responseJSON)
                })
        }).disposed(by: disposeBag)
        
    }
}
