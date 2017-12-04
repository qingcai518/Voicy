//
//  RecordInfo.swift
//  Voicy
//
//  Created by liqc on 2017/12/04.
//  Copyright © 2017年 liqc. All rights reserved.
//

import Foundation

struct RecordInfo {
    var id: String
    var time: String
    var size: String
    var duration: String
    
    init(time: Date, size: Int, duration: Double) {
        self.id = UUID().uuidString
        self.time = getStr(from: time)
        self.size = getFormatFileSize(with: size)
        self.duration = "\(duration)s"
    }
}
