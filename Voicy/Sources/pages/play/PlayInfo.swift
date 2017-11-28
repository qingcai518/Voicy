//
//  PlayInfo.swift
//  Voicy
//
//  Created by liqc on 2017/11/01.
//  Copyright © 2017年 liqc. All rights reserved.
//

import RxSwift

struct PlayInfo {
    var type: VoiceType
    var image: UIImage
    var isSelected = Variable(false)
    
    init(type: VoiceType, image: UIImage, isSelected: Bool = false) {
        self.type = type
        self.image = image
        self.isSelected.value = isSelected
    }
}
