//
//  VoicyModel.swift
//  Voicy
//
//  Created by liqc on 2017/12/04.
//  Copyright © 2017年 liqc. All rights reserved.
//

import RxSwift

class RecordModel {
    var recordInfos = [RecordInfo]()
    
    func getRecordInfos() {
        guard let dirPath = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first?.path else {return}
        guard let files = try? FileManager.default.contentsOfDirectory(atPath: dirPath) else {return}
        let recordFiles = files.filter{$0.hasSuffix(audioBaseFileName)}.map{"\(dirPath)/\($0)"}.filter{FileManager.default.fileExists(atPath: $0)}

        for recordFile in recordFiles {
            guard let attrs = try? FileManager.default.attributesOfItem(atPath: recordFile) else {continue}
            guard let creationDate = attrs[.creationDate] as? Date else {return}
            guard let size = attrs[.size] as? Int else {return}
            
            let dateStr = getStr(from: creationDate)
            let duration = "2s"
            
            let recordInfo = RecordInfo(id: UUID().uuidString, time: dateStr, duration: duration)
            recordInfos.append(recordInfo)
        }
    }
}
