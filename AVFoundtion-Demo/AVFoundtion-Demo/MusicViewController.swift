//
//  MusicViewController.swift
//  AVFoundtion-Demo
//
//  Created by 王潇 on 2022/11/29.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController {
    
    var playing: Bool = false
    
    private var btn: UIButton = {
        let btn = UIButton()
        btn.setTitle("播放", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
        btn.layer.cornerRadius = 10.0
        btn.layer.masksToBounds = true
        btn.backgroundColor = .black
        return btn
    }()
    
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-34)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        btn.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
        
        if let soundFilePath = Bundle.main.url(forResource: "music", withExtension: "mp3") {
            audioPlayer = try? AVAudioPlayer(contentsOf: soundFilePath)
            /// 设置enableRate为true保证能够进行修改播放速率
            audioPlayer?.enableRate = true
            /// rate设置播放速率
            audioPlayer?.rate = 1
            /// volume设置音量 (范围0.0-1.0)
            audioPlayer?.volume = 1
            /// 设置声道(范围-1.0 - 1.0)
            audioPlayer?.pan = 0
            /// 设置循环numberOfLoops -1:无限循环, 0不循环
            audioPlayer?.numberOfLoops = -1
        }
    }
    
    /// 控制音频播放
    @objc func playVideo() {
        if playing {
            audioPlayer?.pause()
            btn.setTitle("播放", for: .normal)
            playing = false
        } else {
            audioPlayer?.play()
            btn.setTitle("暂停", for: .normal)
            playing = true
        }
    }
}

extension MusicViewController: AVAudioPlayerDelegate {
    /// 当音频播放完成时,会调用下面的回调方法
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            playing = false
            btn.setTitle("播放", for: .normal)
        }
    }
    
    /// 当音频播放器在播放过程中遇到解码错误时会调用下面这个方法
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        
    }
    
//  异步播放声音。
//    func play() -> Bool

//  以异步方式播放声音，从音频输出设备时间轴中的指定点开始播放。
//    func play(atTime: TimeInterval) -> Bool


//  暂停播放;声音准备好从它停止的地方恢复播放。
//    func pause()

//  停止播放并撤消播放所需的设置。
//    func stop()

//  通过预加载音频播放器的缓冲区来准备播放。
//    func prepareToPlay() -> Bool

//  淡入到一个新的卷在一个特定的持续时间。
//    func setVolume(Float, fadeDuration: TimeInterval)

//  一个布尔值，指示音频播放器是否正在播放(真)或不(假)。
//    var isPlaying: Bool

//  音频播放器的播放音量，线性范围从0.0到1.0。
//    var volume: Float

//  音频播放器的立体声平移位置。
//    var pan: Float

//  音频播放器的播放速率。
//    var rate: Float

//  一个布尔值，用于指定是否为音频播放器启用播放速率调整。
//    var enableRate: Bool

//  一个声音返回到开始的次数，到达结束时，重复播放。
//    var numberOfLoops: Int

//  音频播放器的委托对象。
//    var delegate: AVAudioPlayerDelegate?

//  一种协议，它允许一个委托响应音频中断和音频解码错误，并完成声音的回放。
//    protocol AVAudioPlayerDelegate

//  音频播放器的设置字典，包含与播放器相关的声音信息。
//    var settings: [String : Any]
}
