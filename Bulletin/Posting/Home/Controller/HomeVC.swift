//
//  HomeVC.swift
//  Bulletin
//
//  Created by huangyuan on 31/03/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

class HomeVC: BaseViewController {
    let tableV = UITableView().then {this in
        this.estimatedRowHeight = 400
        this.rowHeight = UITableViewAutomaticDimension
        this.separatorStyle = .none
        this.register(CreatePostTitleCell.self, forCellReuseIdentifier: "CreatePostTitleCell")
        this.register(CreatePostDescriptionsCell.self, forCellReuseIdentifier: "CreatePostDescriptionsCell")
    }
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RowData>>()

    override func viewDidLoad() {
        super.viewDidLoad()
//        LoginContext.checkLogin {
//            self.navigationController?.title = "Posting"
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension HomeVC {
    override func prepareView() {
         title = "Bulletin"
         _ = creatBarItemRight(title: "Submit")

    }	
    override func rightBarItemClick() {
        self.present(BaseNavigationController(rootViewController: CreatePostVC()), animated: true, completion: nil)
    }
}
