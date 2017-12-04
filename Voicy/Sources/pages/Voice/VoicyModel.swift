//
//  VoicyModel.swift
//  Voicy
//
//  Created by liqc on 2017/12/04.
//  Copyright © 2017年 liqc. All rights reserved.
//

import RxSwift

class VoicyModel {
    var recordInfos = [RecordInfo]()
    
    func getRecordInfos() {
        guard let dirPath = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first?.path else {return}
        guard let files = try? FileManager.default.contentsOfDirectory(atPath: dirPath) else {return}
        let recordFiles = files.filter{$0.hasSuffix(audioBaseFileName)}.map{"\(dirPath)/\($0)"}.filter{FileManager.default.fileExists(atPath: $0)}
        
        for recordFile in recordFiles {
            guard let attrs = try? FileManager.default.attributesOfItem(atPath: recordFile) else {continue}
            guard let creationDate = attrs[FileAttributeKey.creationDate] as? String else {continue}
            guard let size = attrs[FileAttributeKey.size] as? Double else {continue}
            
            print(creationDate + ", \(size)")
        }
    }
}
