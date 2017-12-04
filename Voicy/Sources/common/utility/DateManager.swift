//
//  DateManager.swift
//  Voicy
//
//  Created by liqc on 2017/12/04.
//  Copyright © 2017年 liqc. All rights reserved.
//

import Foundation

func getDate(from str: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    
    return formatter.date(from: str)
}

func getStr(from date: Date, format: String = "yyyy-MM-dd HH:mm:ss") -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    
    return formatter.string(from: date)
}
