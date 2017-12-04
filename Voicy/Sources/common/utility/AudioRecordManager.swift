//
//  AudioManager.swift
//  Voicy
//
//  Created by liqc on 2017/11/01.
//  Copyright © 2017年 liqc. All rights reserved.
//

import AVFoundation

let audioBaseFileName = "_voicy.mp4"

class AudioRecordManager: NSObject {
    var audioRecorder : AVAudioRecorder?
    
//    private lazy var recordSetting : [String : Any] = [
//        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//        AVSampleRateKey: 12000,
//        AVNumberOfChannelsKey: 1,
//        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//    ]
    
    private lazy var recordSetting : [String : Any] =  [AVEncoderAudioQualityKey:NSNumber(value:AVAudioQuality.low.rawValue),
        AVNumberOfChannelsKey:NSNumber(value:2),
        AVSampleRateKey:NSNumber(value:44100.0),
        AVFormatIDKey:NSNumber(value:kAudioFormatMPEG4AAC)
    ]
    
    override init() {
        super.init()
    }
    
    func startRecord(to fileName: String) -> URL? {
        endRecord()
        
        guard let fileUrl = getFileURL(with: fileName) else {return nil}
        
        print("file url = \(fileUrl.absoluteString)")
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileUrl, settings: recordSetting)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let error {
            print("error = \(error)")
            return nil
        }
        guard let recorder = audioRecorder else {return nil}
        if recorder.isRecording {return nil}
        recorder.record()
        return fileUrl
    }
    
    func endRecord() {
        audioRecorder?.stop()
        audioRecorder = nil
    }
    
    private func getFileURL(with fileName: String) -> URL? {
        guard let dirUrl = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let fileUrl = dirUrl.appendingPathComponent(fileName)
        return fileUrl
    }
}
