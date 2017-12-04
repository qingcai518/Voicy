//
//  VoicyExtension.swift
//  Voicy
//
//  Created by liqc on 2017/12/04.
//  Copyright © 2017年 liqc. All rights reserved.
//

import UIKit

extension VoicyController: UITableViewDelegate {
    
}

extension VoicyController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recordInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "VoicyCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? VoicyCell {
            let info = viewModel.recordInfos[indexPath.row]
            cell.configure(with: info)
        }
    }
}
