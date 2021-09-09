//
//  EffectControView.swift
//  Effect-List-Demo
//
//  Created by 王潇 on 2021/9/8.
//

import UIKit
import SnapKit
/// 按钮距离父视图左右的距离
private let superMargin: CGFloat = 16
/// 按钮大小
private let buttonSize: CGSize = CGSize(width: 40, height: 40)
/// 标题的字体大小
private let fontSize: CGFloat = 12
/// 标题的字体颜色
private let fontColor: UIColor = UIColor.hex("#000000")

class MSListControlView: UIView {
    /// 清除事件点击的闭包
    typealias clearBlock = (() -> Void?)
    /// 确定事件点击的闭包
    typealias determineBlock = (() -> Void?)
    
    /// 清除按钮
    private var clearBtn: MSListBtn!
    /// 标题Label
    private var titleLabel: UILabel!
    /// 确定按钮
    private var determineBtn: MSListBtn!
    /// 点击清除的回调
    var clearBack: clearBlock?
    /// 点击确定的回调
    var determineBack: determineBlock?
    /// 标题文字
    var titleText: String? {
        didSet {
            if let text = titleText {
                titleLabel.text = text
            }
        }
    }
    /// 按钮点击状态
    var btnClickState: Bool = false {
        didSet {
            updateBtnState()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        addTouchEvent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MSListControlView {
    // MARK: - UIConfig
    func setUI() {
        clearBtn = MSListBtn()
        self.addSubview(clearBtn)
        clearBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(superMargin)
            make.size.equalTo(buttonSize)
            make.centerY.equalToSuperview()
        }
        clearBtn.imageName = "list_clear_btn"
        
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(fontSize)
        }
        titleLabel.font = .systemFont(ofSize: fontSize, weight: .bold)
        titleLabel.textColor = fontColor
        
        determineBtn = MSListBtn()
        self.addSubview(determineBtn)
        determineBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-superMargin)
            make.size.equalTo(buttonSize)
            make.centerY.equalToSuperview()
        }
        determineBtn.imageName = "list_yes_btn"
    }
    
    // MARK: - 点击事件
    func addTouchEvent() {
        clearBtn.addTarget(self, action: #selector(clearClick), for: .touchUpInside)
        determineBtn.addTarget(self, action: #selector(determineClick), for: .touchUpInside)
    }
    @objc func clearClick() {
        clearBack?()
    }
    @objc func determineClick() {
        determineBack?()
    }
    
    // MARK: - 按钮状态刷新
    func updateBtnState() {
        if btnClickState {
            clearBtn.isEnabled = true
            determineBtn.isEnabled = true
        } else {
            clearBtn.isEnabled = false
            determineBtn.isEnabled = false
        }
    }
}
