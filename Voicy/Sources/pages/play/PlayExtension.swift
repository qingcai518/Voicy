//
//  PlayExtension.swift
//  Voicy
//
//  Created by liqc on 2017/11/01.
//  Copyright © 2017年 liqc. All rights reserved.
//

import UIKit
import AVFoundation

extension PlayController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        for i in 0..<viewModel.playInfos.count {
            let info = viewModel.playInfos[i]
            info.isSelected.value = i == indexPath.row
        }
        
        let currentInfo = viewModel.playInfos[indexPath.row]
        typeImageView.image = currentInfo.image
        titleLbl.text = currentInfo.type.rawValue
        currentType = currentInfo.type
        playVoice()
        
        customView.isHidden = currentType != .custom
    }
}

extension PlayController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - 24
        let width = height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
}

extension PlayController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.playInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "VoiceCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? VoiceCell else {return}
        let info = viewModel.playInfos[indexPath.row]
        cell.configure(with: info)
    }
}

extension PlayController: AudioPlayManagerDelegate {
    func didFinishPlay() {
        stopPlay()
    }
}
