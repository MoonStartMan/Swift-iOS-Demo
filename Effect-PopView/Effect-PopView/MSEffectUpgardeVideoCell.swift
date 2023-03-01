//
//  MSEffectUpgardeVideoCell.swift
//  Effect-PopView
//
//  Created by 王潇 on 2023/2/28.
//

import UIKit
import SnapKit
import AVFoundation

class MSEffectUpgardeVideoCell: UITableViewCell {
    
    var model: MSEffectUpgradeModel? {
        didSet {
            if let model = model {
                titleLabel.text = model.title
                setLineSpacing(text: model.subTitle)
            }
        }
    }
    
    private var gradientLayer: CAGradientLayer = CAGradientLayer()
    
    private var videoContentView: UIView = UIView()
    
    private var playerLooper: AVPlayerLooper!
    
    private var queuePlayer: AVQueuePlayer!

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .hex("#FFFFFF")
        return label
    }()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .hex("#FFFFFF")
        label.numberOfLines = 0
        return label
    }()
    
    private var tipsView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        view.backgroundColor = .hex("#D0FE18", 0.1)
        return view
    }()
    
    private var tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "升级"
        label.textColor = .hex("#D0FE18")
        label.font = .systemFont(ofSize: 10, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.addHintVideo()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .hex("#1A1A1A")
        let topColor = UIColor.hex("#333333", 1)
        let bottomColor = UIColor.hex("#333333", 0)
        let gradientColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [NSNumber] = [0.0, 1.0]
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        contentView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(videoContentView)
        videoContentView.snp.makeConstraints { make in
            make.width.height.equalTo(64)
            make.left.equalTo(24)
            make.top.equalTo(12)
            make.bottom.equalTo(-12)
        }
        
        contentView.addSubview(tipsView)
        tipsView.snp.makeConstraints { make in
            make.right.equalTo(-24)
            make.height.equalTo(18)
            make.width.equalTo(28)
            make.centerY.equalToSuperview()
        }
        
        tipsView.addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(videoContentView.snp.right).offset(8)
            make.top.equalTo(19)
            make.right.equalTo(tipsView.snp.left).offset(-16)
        }
        
        contentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(videoContentView.snp.right).offset(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.right.equalTo(tipsView.snp.left).offset(-16)
        }
    }
    
    private func addHintVideo() {
        if let filePath = Bundle.main.path(forResource: "EffectUpgradeVideo", ofType: "mp4") {
            var videoUrl: URL?
            if #available(iOS 16.0, *) {
                videoUrl = URL(filePath: filePath)
            } else {
                videoUrl = URL(fileURLWithPath: filePath)
            }
            if let videoUrl = videoUrl {
                let playerItem = AVPlayerItem(url: videoUrl)
                queuePlayer = AVQueuePlayer(playerItem: playerItem)
                playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
                let player = AVPlayerLayer(player: queuePlayer)
                player.frame = videoContentView.bounds
                player.videoGravity = .resizeAspectFill
                videoContentView.layer.addSublayer(player)
                queuePlayer.play()
            }
        }
    }
    
    /// 设置副标题行间距
    private func setLineSpacing(text: String) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        subTitleLabel.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: style])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = contentView.bounds
    }
    
}
