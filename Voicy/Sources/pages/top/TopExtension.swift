//
//  TopExtension.swift
//  Voicy
//
//  Created by liqc on 2017/11/01.
//  Copyright © 2017年 liqc. All rights reserved.
//

import UIKit
import AVFoundation

extension TopController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {return}
        toPlayPage()
        backView.isHidden = true
        endTimer()
        timerLbl.text = "0s"
        counter = 0
    }
}
