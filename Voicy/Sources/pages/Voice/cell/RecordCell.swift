//
//  VoicyCell.swift
//  Voicy
//
//  Created by liqc on 2017/12/04.
//  Copyright © 2017年 liqc. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    
    func configure(with recordInfo: RecordInfo) {
        timeLbl.text = recordInfo.time
        durationLbl.text = recordInfo.duration
    }
}
