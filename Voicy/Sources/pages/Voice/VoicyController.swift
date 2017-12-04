//
//  VoicyController.swift
//  Voicy
//
//  Created by liqc on 2017/12/04.
//  Copyright © 2017年 liqc. All rights reserved.
//

import UIKit

class VoicyController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModel = VoicyModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension VoicyController {
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    fileprivate func getData() {
        viewModel.getRecordInfos()
        tableView.reloadData()
    }
}
