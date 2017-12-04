//
//  ViewController.swift
//  Voicy
//
//  Created by liqc on 2017/10/31.
//  Copyright © 2017年 liqc. All rights reserved.
//

import UIKit
import RxCocoa

class TopController: VoicyViewController {
    @IBOutlet weak var recordBtn : UIButton!
    @IBOutlet weak var backView : UIView!
    @IBOutlet weak var waveView: UIImageView!
    @IBOutlet weak var timerLbl: UILabel!
    
    let viewModel = TopViewModel()
    var timer: Timer?
    var waveTimer: Timer?
    
    // variables.
    let manager = AudioRecordManager()
    var counter = 0
    
    // audio.
    var fileUrl:URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWaveView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TopController {
    fileprivate func setupWaveView() {
        backView.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        
        let images = [UIImage(named: "icon_wave1")!, UIImage(named: "icon_wave2")!]
        waveView.animationImages = images
        waveView.animationDuration = 0.3
        waveView.animationRepeatCount = 0
        waveView.startAnimating()
    }
    
    fileprivate func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTimerLbl), userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc
    func setTimerLbl() {
        counter += 1
        timerLbl.text = "\(counter)s"
    }
    
    func toPlayPage() {
        guard let next = UIStoryboard(name: "Play", bundle: nil).instantiateInitialViewController() as? PlayController else {return}
        next.fileUrl = fileUrl
        next.timeStr = "\(counter)s"
        present(next, animated: true, completion: nil)
    }
}

extension TopController {
    @IBAction func startRecording() {
        backView.isHidden = false
        startTimer()
        let fileName = "\(Date().timeIntervalSince1970)\(audioBaseFileName)"
        fileUrl = manager.startRecord(to: fileName)
        manager.audioRecorder?.delegate = self
    }
    
    @IBAction func endRecording() {
         manager.endRecord()
    }
    
    @IBAction func tel() {
        UIApplication.shared.open(URL(string: "telprompt://08046189518")!, options: [:]) { flag in
            print("result = \(flag)")
        }
    }
    
    @IBAction func openRecords() {
        guard let voicy = UIStoryboard(name: "Record", bundle: nil).instantiateInitialViewController() else {return}
        let next = UINavigationController(rootViewController: voicy)
        present(next, animated: true, completion: nil)
    }
}
