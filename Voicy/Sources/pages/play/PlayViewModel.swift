//
//  PlayViewModel.swift
//  Voicy
//
//  Created by liqc on 2017/11/01.
//  Copyright © 2017年 liqc. All rights reserved.
//

import RxSwift

class PlayViewModel {
    var playInfos = [PlayInfo]()
    
    func setPlayInfos() {
        let info1 = PlayInfo(type: .original, image: UIImage(named: "icon_man")!, isSelected: true)
        let info2 = PlayInfo(type: .woman, image: UIImage(named: "icon_woman")!)
        let info3 = PlayInfo(type: .man, image: UIImage(named: "icon_woman")!)
        let info4 = PlayInfo(type: .loli, image: UIImage(named: "icon_woman")!)
        let info5 = PlayInfo(type: .papi, image: UIImage(named: "icon_woman")!)
        let info6 = PlayInfo(type: .original, image: UIImage(named: "icon_woman")!)
        let info7 = PlayInfo(type: .original, image: UIImage(named: "icon_woman")!)
        let info8 = PlayInfo(type: .original, image: UIImage(named: "icon_woman")!)
        let info9 = PlayInfo(type: .original, image: UIImage(named: "icon_woman")!)
        let info10 = PlayInfo(type: .original, image: UIImage(named: "icon_woman")!)
        
        playInfos = [info1, info2, info3, info4, info5, info6, info7, info8, info9, info10]
    }
}
