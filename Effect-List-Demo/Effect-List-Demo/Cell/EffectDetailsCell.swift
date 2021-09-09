//
//  EffectDetailsCell.swift
//  Effect-List-Demo
//
//  Created by 王潇 on 2021/9/8.
//

import UIKit
import SnapKit

/// 圆角大小
private let radius: CGFloat = 10
/// 默认态背景色
private let normalBgColor: UIColor = UIColor.hex("#FFFFFF", 0.1)
/// 选中态背景色
private let activeBgColor: UIColor = UIColor.hex("#1A1A1A", 0.3)
/// 图片的大小
private let imageSize: CGSize = CGSize(width: 32, height: 32)
/// 遮罩层高度
private let coverHeight: CGFloat = 18
/// 遮罩层圆角
private let cornerRadius: CGFloat = 10
/// 文字大小
private let fontSize: CGFloat = 10
/// 字体颜色
private let fontColor: UIColor = UIColor.hex("#FFFFFF")
/// 遮罩按钮距离底部的距离
private let marignBottom: CGFloat = 18
/// 编辑图片
private let editImage: UIImage = UIImage(named: "list_edit_btn") ?? UIImage()

class EffectDetailsCell: UICollectionViewCell {
    /// 特效图片
    private var effectImageView: UIImageView!
    /// 文字遮罩层
    private var textCoverView: UIView!
    /// 文字Label
    private var textLabel: UILabel!
    /// 特效遮罩层
    private var coverView: UIView!
    /// 遮罩层按钮
    private var coverBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        addClick()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIConfig
extension EffectDetailsCell {
    func setUI() {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        
        effectImageView = UIImageView()
        self.addSubview(effectImageView)
        effectImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textCoverView = UIView()
        self.addSubview(textCoverView)
        textCoverView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(coverHeight)
        }
        textCoverView.layer.cornerRadius = cornerRadius
        textCoverView.backgroundColor = normalBgColor
        
        textLabel = UILabel()
        textCoverView.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        textLabel.font = .systemFont(ofSize: fontSize)
        textLabel.textColor = .blue
        /// FIXME
        textLabel.text = "A003"
        textLabel.textAlignment = .center
        
        coverView = UIView()
        self.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        coverView.backgroundColor = activeBgColor
        
        coverBtn = UIButton()
        coverView.addSubview(coverBtn)
        coverBtn.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-marignBottom)
        }
        coverBtn.setImage(editImage, for: .normal)
        coverBtn.isHidden = true
    }
}

// MARK: - 添加点击事件
extension EffectDetailsCell {
    func addClick() {
        coverBtn.addTarget(self, action: #selector(clickEdit), for: .touchUpInside)
    }
    
    @objc func clickEdit() {
        print("点击了编辑")
    }
}

// MARK: - 切换点击状态
extension EffectDetailsCell{
    func changeActive(isActive: Bool) {
        if isActive {
            self.layer.borderWidth = 2
            self.layer.borderColor = activeBgColor.cgColor
            coverBtn.isHidden = false
        } else {
            self.layer.borderWidth = 0
            self.layer.borderColor = activeBgColor.cgColor
            coverBtn.isHidden = true
        }
    }
}
