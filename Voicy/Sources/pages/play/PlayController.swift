//
//  PlayController.swift
//  Voicy
//
//  Created by liqc on 2017/11/01.
//  Copyright © 2017年 liqc. All rights reserved.
//

import UIKit

class PlayController: VoicyViewController {
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var animationView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    
    let viewModel = PlayViewModel()
    let manager = AudioPlayManager()
    var currentType = VoiceType.original
    
    // params.
    var fileUrl: URL?
    var timeStr: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        setView()
        setupCollectionView()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func playVoice() {
        manager.playSound(fileUrl: fileUrl, voiceType: currentType)
        self.animationView.startAnimating()
    }
    
    func stopPlay() {
        DispatchQueue.main.async {
            self.animationView.stopAnimating()
        }
    }
}

extension PlayController {
    fileprivate func setView() {
        timeLbl.text = timeStr

        playBtn.setBackgroundImage(createImage(with: UIColor.voiceOriginal, 1), for: .normal)
        playBtn.setBackgroundImage(createImage(with: UIColor.lightGray, 1), for: .highlighted)
        
        let images = [UIImage(named: "icon_voice1")!, UIImage(named: "icon_voice2")!, UIImage(named: "icon_voice3")!]
        animationView.animationImages = images
        animationView.animationDuration = 0.8
        animationView.animationRepeatCount = 0
        playVoice()
        
        playBtn.addSubview(animationView)
        playBtn.rx.tap.asObservable().bind { [weak self] in
            self?.playVoice()
        }.disposed(by: disposeBag)
    }
    
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
    }
    
    fileprivate func getData() {
        viewModel.setPlayInfos()
        collectionView.reloadData()
    }
}

extension PlayController {
    @IBAction func doClose() {
        self.dismiss(animated: true, completion: nil)
        stopPlay()
    }
}
