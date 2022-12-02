//
//  ViewController.swift
//  AVFoundtion-Demo
//
//  Created by 王潇 on 2022/11/28.
//

import UIKit
import SnapKit
import AVFoundation

class ViewController: UIViewController {
    
    private var isPlaying: Bool = false
    
    private lazy var player: AVPlayerLayer = {
         if let filePath = Bundle.main.path(forResource: "1", ofType: "mp4") {
             let videoURL = URL(fileURLWithPath: filePath)
             let playerItem = AVPlayerItem(url: videoURL)
             let player = AVPlayer(playerItem: playerItem)
             let playerLayer = AVPlayerLayer(player: player)
             playerLayer.frame = UIScreen.main.bounds
             playerLayer.videoGravity = .resizeAspectFill
             return playerLayer
         } else {
             return AVPlayerLayer()
         }
     }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.layer.addSublayer(player)
        self.navigationController?.navigationBar.isHidden = true
        
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-34)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        btn.addGestureRecognizer(tap)
    }

    @objc func playVideo() {
        if isPlaying {
            player.player?.pause()
            btn.setTitle("播放", for: .normal)
            isPlaying = false
        } else {
            player.player?.play()
            btn.setTitle("暂停", for: .normal)
            isPlaying = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        player.frame = view.bounds
    }
}

