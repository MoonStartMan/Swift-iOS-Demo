//
//  RecorderViewController.swift
//  AVFoundtion-Demo
//
//  Created by 王潇 on 2022/11/29.
//

import UIKit
import AVFoundation

class RecorderViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    
    var record: AVAudioRecorder?
    
    var avSpeech: AVSpeechSynthesizer = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //1. 创建需要合成的声音类型
//        let voice = AVSpeechSynthesisVoice(language: "zh-CN")
        
        //2. 创建合成的语音类
//        let utterance = AVSpeechUtterance(string: "")
//        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
//        utterance.voice = voice
//        utterance.volume = 1
//        utterance.postUtteranceDelay = 0.1
//        utterance.pitchMultiplier = 1
        //开始播放
//        avSpeech.speak(utterance)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// 开始录音
        /// 1.1创建路径
        guard let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)).first else { return }
        let filePath = "\(path)/test.caf"
        let fileURL = URL(string: filePath)
        
        do {
            try FileManager.default.removeItem(atPath: filePath)
        } catch {
            print(error)
        }
        
        /// 1.2创建一个录音配置字典
        let configDic: [String: AnyObject] = [
            //  编码格式
            AVFormatIDKey: NSNumber(integerLiteral: Int(kAudioFormatLinearPCM)),
            //  采样率
            AVSampleRateKey: NSNumber(floatLiteral: 11025.0),
            //  通道数
            AVNumberOfChannelsKey: NSNumber(value: 2),
            //  录音质量
            AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)
        ]
        
        /// 1.3创建录音对象
        do {
            if let url = fileURL {
                record = try AVAudioRecorder(url: url, settings: configDic)
            }
        } catch {
            print(error)
            return
        }
        
        /// 2.准备录音
        record?.prepareToRecord()
        
        /// 3.开始录音
        record?.record()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /// 获取当前的录音(长度,录音多久了)
        let duration = record?.currentTime ?? 0
        
        print("\(record?.currentTime)")
        
        if duration < 2 {
            print("录音时间太短, 请重新录音")
            
            //  删除当前录音的文件
            //  删除文件,一定要保证,录音停止
            record?.stop()
            record?.deleteRecording()
            return
        }
        
        print("录音时间刚刚好,可以保存")
        record?.stop()
        
        guard let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)).first else { return }
        let filePath = "\(path)/test.caf"
        if let fileURL = URL(string: filePath) {
            audioPlayer = try? AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.volume = 2.0
            audioPlayer?.play()
        }
    }
}
