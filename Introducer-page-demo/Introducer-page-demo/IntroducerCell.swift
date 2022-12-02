//
//  IntroducerCell.swift
//  Introducer-page-demo
//
//  Created by 王潇 on 2022/10/22.
//

import UIKit
import AVFoundation
import SnapKit

class IntroducerCell: UICollectionViewCell {
    
    private var contentCoverView: UIView = UIView()
    
    private var topCoverView: UIView = UIView()
    
    private var backgroundGradientLayer: CAGradientLayer = CAGradientLayer()
    
    private var player: AVPlayerLayer?
    
    private var titleLabel: UILabel = UILabel()
    
    private var clickBtnLayer: CAGradientLayer = CAGradientLayer()
    
    private var contentLabel: UILabel = UILabel()
    
    private var clickBtn: UIButton = UIButton()
    
    var clickBtnBack: (() -> Void)?
    
    var model: IntroduceItemModel? {
        didSet {
            if let itemModel = model {
                titleLabel.text = itemModel.title
                contentLabel.text = itemModel.content
                setActive(isActive: itemModel.active)
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(contentCoverView)
        contentCoverView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(300)
        }
        
        addSubview(topCoverView)
        topCoverView.snp.makeConstraints { make in
            make.bottom.equalTo(contentCoverView.snp.top)
            make.left.right.top.equalToSuperview()
        }
        topCoverView.backgroundColor = .clear
        
        let gradientColors = [
            UIColor(red: 255, green: 255, blue: 255, alpha: 0.8).cgColor,
            UIColor(red: 255, green: 255, blue: 255, alpha: 0).cgColor
        ]
        let gradientLocations: [NSNumber] = [0.0, 1.0]
        backgroundGradientLayer.colors = gradientColors
        backgroundGradientLayer.locations = gradientLocations
        backgroundGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        backgroundGradientLayer.endPoint = CGPoint(x: 1, y: 1)
        contentCoverView.layer.insertSublayer(backgroundGradientLayer, at: 0)
        
        contentCoverView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.left.right.equalToSuperview()
            make.height.equalTo(36)
        }
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(red: 0.102, green: 0.102, blue: 0.102, alpha: 1)
        
        contentCoverView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(48)
            make.right.equalToSuperview().offset(-48)
        }
        contentLabel.numberOfLines = 0
        contentLabel.textColor = .gray
        contentLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        contentLabel.textAlignment = .center
        
        contentCoverView.addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-58)
            make.left.equalToSuperview().offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(54)
        }
        clickBtn.layer.cornerRadius = 18.0
        clickBtn.layer.masksToBounds = true
        clickBtn.setTitleColor(UIColor(red: 0.102, green: 0.102, blue: 0.102, alpha: 1.0), for: .normal)
        clickBtn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        clickBtn.backgroundColor = UIColor(red: 0.941, green: 0.944, blue: 0.96, alpha: 1)
        clickBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        
        let btnGradientColors = [
            UIColor(red: 0.68, green: 1, blue: 0, alpha: 1).cgColor,
            UIColor(red: 0.68, green: 1, blue: 0, alpha: 0.6).cgColor
        ]
        let btnGradientLocations: [NSNumber] = [0.0, 1.0]
        clickBtnLayer.colors = btnGradientColors
        clickBtnLayer.locations = btnGradientLocations
        clickBtnLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        clickBtnLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        clickBtn.layer.insertSublayer(clickBtnLayer, at: 0)
        clickBtnLayer.isHidden = true
        
        showAnimationView()
    }
    
    @objc func btnClick() {
        clickBtnBack?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundGradientLayer.frame = contentCoverView.bounds
        clickBtnLayer.frame = clickBtn.bounds
    }
    
    private func setActive(isActive: Bool) {
        if isActive {
            clickBtnLayer.isHidden = false
            clickBtn.setTitle("Let's Blurrr!", for: .normal)
        } else {
            clickBtnLayer.isHidden = true
            clickBtn.setTitle("NEXT", for: .normal)
        }
    }
    
    func showAnimationView() {
        titleLabel.snp.updateConstraints { make in
            make.left.equalToSuperview().offset(-UIScreen.main.bounds.size.width)
        }
        contentLabel.snp.updateConstraints { make in
            make.left.equalToSuperview().offset(-UIScreen.main.bounds.size.width)
        }
        self.alpha = 0
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.alpha = 1
            self.titleLabel.snp.updateConstraints { make in
                make.left.equalToSuperview()
            }
            self.contentLabel.snp.updateConstraints { make in
                make.left.equalToSuperview().offset(48)
            }
            self.titleLabel.layoutIfNeeded()
            self.contentLabel.layoutIfNeeded()
        }
    }
}

struct IntroduceItemModel {
    var title: String
    var content: String
    var videoName: String
    var active: Bool
}
