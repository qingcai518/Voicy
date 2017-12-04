//
//  VoicyController.swift
//  Voicy
//
//  Created by liqc on 2017/12/04.
//  Copyright © 2017年 liqc. All rights reserved.
//

import UIKit

class RecordController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeBtn: UIButton!
    let viewModel = RecordModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RecordController {
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    fileprivate func getData() {
        viewModel.getRecordInfos()
        tableView.reloadData()
    }
}

extension RecordController {
    @IBAction func doClose() {
        self.dismiss(animated: true, completion: nil)
    }
}
