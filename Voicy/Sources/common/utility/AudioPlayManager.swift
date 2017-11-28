//
//  AudioPlayManager.swift
//  Voicy
//
//  Created by liqc on 2017/11/01.
//  Copyright © 2017年 liqc. All rights reserved.
//

import AVFoundation

protocol AudioPlayManagerDelegate {
    func didFinishPlay()
}

class AudioPlayManager: NSObject {
    var engine: AVAudioEngine?
    var audioPlayerNode: AVAudioPlayerNode?
    var delegate: AudioPlayManagerDelegate?
    
    override init() {
        super.init()
    }

    func playSound(fileUrl: URL?, voiceType: VoiceType){
        guard let fileUrl = fileUrl else { return }
        guard let audioFile = try? AVAudioFile(forReading: fileUrl) else { return }
        
        engine = AVAudioEngine()
        guard let engine = engine else {return}
        
        // Prepare AVAudioPlayerNode
        audioPlayerNode = AVAudioPlayerNode()
        guard let audioPlayerNode = audioPlayerNode else {return}
        engine.attach(audioPlayerNode)
        
        let effect = getEffect(with: voiceType)
        
        // Prepare AVAudioUnitTimePitch
        let audioUnitTimePitch = AVAudioUnitTimePitch()
        
        print("before pitch = \(audioUnitTimePitch.pitch), rate = \(audioUnitTimePitch.rate), overlap = \(audioUnitTimePitch.overlap)")
        
        audioUnitTimePitch.overlap = 8.0
        audioUnitTimePitch.pitch = effect.pitch
        audioUnitTimePitch.rate = effect.rate
        engine.attach(audioUnitTimePitch)
        
        // Connect Nodes
        engine.connect(audioPlayerNode, to: audioUnitTimePitch, format: audioFile.processingFormat)
        engine.connect(audioUnitTimePitch, to: engine.mainMixerNode, format: audioFile.processingFormat)
        
        engine.prepare()
        
        try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: { [weak self] in
            print("Completion.")
            self?.delegate?.didFinishPlay()
        })
        
        try? engine.start()
        audioPlayerNode.play()
    }
    
    private func getEffect(with voiceType: VoiceType) -> (pitch:Float, rate:Float) {
        switch voiceType {
        case .man:
            return (pitch: 1, rate: 1)
        case .woman:
            return (pitch: 500, rate: 1)
        case .papi:
            return (pitch: 1000, rate: 1.5)
        case .loli:
            return (pitch: 1, rate: 1)
        default:
            return (pitch: 0, rate: 1)
        }
    }
}

