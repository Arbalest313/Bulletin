//
//  CreatePostVC.swift
//  Bulletin
//
//  Created by huangyuan on 20/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

class CreatePostVM : BaseModel {
    var title : Variable<String> = Variable("")
    var descriptions: Variable<String> = Variable("")
    var postType: Variable<String> = Variable("0")
    var extraInfo: Variable<String> = Variable("")
    
    var nextBtnEnable : Variable<Bool> = Variable(false)
    var submitBtnEnable : Variable<Bool> = Variable(false)
    override func prepareInit() {
        Observable.combineLatest([title.asObservable(), descriptions.asObservable()]).map { (values) -> Bool in
            return values[0].length > 4 && values[1].length > 4
        }.distinctUntilChanged().subscribe(onNext: {[unowned self] (enable) in
            self.nextBtnEnable.value = enable
        }).disposed(by: disposeBag)
        
        Observable.combineLatest([title.asObservable(), descriptions.asObservable(),postType.asObservable(), extraInfo.asObservable()]).map { (values) -> Bool in
            return (values[0].length > 4 && values[1].length > 4
            && values[2].length > 1 && values[3].length > 1)
            }.distinctUntilChanged().subscribe(onNext: {[unowned self] (enable) in
                self.submitBtnEnable.value = enable
            }).disposed(by: disposeBag)
    }
}


class CreatePostVC: BaseViewController {
    let tableV = UITableView().then {this in
        this.estimatedRowHeight = 400
        this.rowHeight = UITableViewAutomaticDimension
        this.separatorStyle = .none
        this.register(CreatePostTitleCell.self, forCellReuseIdentifier: "CreatePostTitleCell")
        this.register(CreatePostDescriptionsCell.self, forCellReuseIdentifier: "CreatePostDescriptionsCell")
    }
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RowData>>()
    
    let viewModel = CreatePostVM()
    
    var rightBarItemBtn = UIButton()
    var leftBarItemBtn = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


extension CreatePostVC {
    override func leftBarItemClick() {
        dismiss(animated: true, completion: nil)
    }
    override func rightBarItemClick() {
        let vc = CreatePostFillTipInfoVC(viewModel:viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CreatePostVC {
    override func prepareView() {
        title = "Creat your Request"
        rightBarItemBtn = creatBarItemRight(title: "Next")
        leftBarItemBtn = creatBarItemLeft(title: "Cancel")
        
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
        
        viewModel.nextBtnEnable.asObservable().do(onNext: {[unowned self] enable in
            self.rightBarItemBtn.alpha = enable ? 1 : 0.5
        }).bindTo(rightBarItemBtn.rx.isEnabled).disposed(by: disposeBag)
        
    }
}
