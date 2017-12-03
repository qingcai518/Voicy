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
    var audioUnitTimePitch: AVAudioUnitTimePitch?
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
        audioUnitTimePitch = AVAudioUnitTimePitch()
        guard let audioUnitTimePitch = audioUnitTimePitch else {return}
        
        print("before pitch = \(audioUnitTimePitch.pitch), rate = \(audioUnitTimePitch.rate), overlap = \(audioUnitTimePitch.overlap)")
        
        audioUnitTimePitch.overlap = effect.overlap
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
    
    private func getEffect(with voiceType: VoiceType) -> (pitch:Float, rate:Float, overlap: Float) {
        switch voiceType {
        case .original:
            return (pitch: 1, rate: 1, overlap: 8)
        case .man:
            return (pitch: -500, rate: 1, overlap: 8)
        case .woman:
            return (pitch: 500, rate: 1, overlap: 8)
        case .papi:
            return (pitch: 800, rate: 1.2, overlap: 8)
        case .loli:
            return (pitch: 1, rate: 1, overlap: 8)
        default:
            return (pitch: customPitch, rate: customRate, overlap: customOverlap)
        }
    }
}

