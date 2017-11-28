//
//  VoiceCell.swift
//  Voicy
//
//  Created by liqc on 2017/11/01.
//  Copyright © 2017年 liqc. All rights reserved.
//

import UIKit
import RxSwift

class VoiceCell: UICollectionViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configure(with info: PlayInfo) {
        iconView.image = info.image
        titleLbl.text = info.type.rawValue
        
        info.isSelected.asObservable().bind { [weak self] value in
            self?.backgroundColor = value ? UIColor.lightGray: UIColor.white
        }.disposed(by: disposeBag)
    }
}
