//
//  AppUtility.swift
//  Voicy
//
//  Created by liqc on 2017/11/01.
//  Copyright © 2017年 liqc. All rights reserved.
//

import Foundation
import UIKit

func createImage(with color: UIColor, _ scale: Double) -> UIImage? {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1 * scale)
    UIGraphicsBeginImageContext(rect.size)
    
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}

func getFormatFileSize(with size: Int) -> String {
    let sizeK = Double(size) / 1024
    let sizeM = Double(size) / (1024 * 1024)
    
    if sizeM >= 1 {
        return "".appendingFormat("%.2fm", sizeM)
    }
    
    return "".appendingFormat("%.2fk", sizeK)
}
