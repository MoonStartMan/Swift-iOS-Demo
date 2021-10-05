//
//  MSPopupWindow.swift
//  Aries
//
//  Created by 王潇 on 2021/9/23.
//

import UIKit
import SnapKit

enum MSPopupWindowType {
    case AlertHideView
    /// 仅有图标和提示文字的弹窗
    /// ---------------
    ///    -------
    ///    |              |
    ///    -------
    ///
    ///     Text
    ///
    /// ---------------
    case CloseAlertView
    /// 一个按钮带关闭按钮的弹窗
    /// ------------------
    ///                x
    ///     ---------
    ///
    ///        Title
    ///
    ///       SubTitle
    ///
    ///        btn
    ///
    ///    -----------
    case ChooseAlertView
    /// 两个按钮带关闭按钮的弹窗
    ///     ----------------
    ///                x
    ///     -----------
    ///        Title
    ///
    ///       SubTitle
    ///
    ///   cancelBtn   determinBtn
    ///
    ///    -----------
    case DetermineAlertView
    /// 一个按钮不带关闭按钮的弹窗
    /// ---------------
    ///    -------
    ///    |              |
    ///    -------
    ///
    ///     Text
    ///
    ///   determinBtn
    ///
    /// ---------------
}

class MSPopupWindowView: UIView {
    /// 标题
    public var title: String? {
        didSet {
            if let titleText = title {
                self.titleLabel.text = titleText
            }
        }
    }
    
    /// 标题文字样式
    public var titleFont: UIFont =  .systemFont(ofSize: 16, weight: .bold){
        didSet {
            self.titleLabel.font = titleFont
        }
    }
    
    /// 标题文字颜色
    public var titleColor: UIColor = .hex("#000000") {
        didSet {
            self.titleLabel.textColor = titleColor
        }
    }
    
    /// 副标题
    public var subTitle: String? {
        didSet {
            if let subTitleText = subTitle {
                self.subTitleLabel.text = subTitleText
            }
        }
    }
    
    /// 副标题文字样式
    public var subTitleFont: UIFont = .systemFont(ofSize: 12, weight: .thin) {
        didSet {
            self.subTitleLabel.font = subTitleFont
        }
    }
    
    /// 副标题文字颜色
    public var subTitleColor: UIColor = .hex("#999999") {
        didSet {
            self.subTitleLabel.textColor = subTitleColor
        }
    }
    
    /// 确定按钮文字
    public var determineBtnName: String? {
        didSet {
            if let determineBtnNameText = determineBtnName {
                self.determineBtn.setTitle(determineBtnNameText, for: .normal)
            }
        }
    }
    
    /// 确定按钮背景颜色
    public var determineBtnBgColor: UIColor = .hex("#D1FF18") {
        didSet {
            self.determineBtn.backgroundColor = determineBtnBgColor
        }
    }
    
    /// 确定按钮字体样式
    public var determineBtnTextFont: UIFont = .systemFont(ofSize: 14, weight: .bold) {
        didSet {
            self.determineBtn.titleLabel?.font = determineBtnTextFont
        }
    }
    
    /// 确定按钮字体颜色
    public var determineBtnTextColor: UIColor = .hex("#000000") {
        didSet {
            self.determineBtn.setTitleColor(determineBtnTextColor, for: .normal)
        }
    }
    
    /// 取消按钮文字
    public var cancelBtnName: String? {
        didSet {
            if let cancelBtnNameText = cancelBtnName {
                self.cancelBtn.setTitle(cancelBtnNameText, for: .normal)
            }
        }
    }
    
    /// 取消按钮背景颜色
    public var cancelBtnBgColor: UIColor = .hex("#F7F7F7") {
        didSet {
            self.cancelBtn.backgroundColor = cancelBtnBgColor
        }
    }
    
    /// 取消按钮字体样式
    public var cancelBtnTextFont: UIFont = .systemFont(ofSize: 14, weight: .bold) {
        didSet {
            self.cancelBtn.titleLabel?.font = cancelBtnTextFont
        }
    }
    
    /// 取消按钮字体颜色
    public var cancelBtnTextColor: UIColor = .hex("#999999") {
        didSet {
            self.cancelBtn.setTitleColor(cancelBtnTextColor, for: .normal)
        }
    }
    
    /// icon图片
    public var iconImage: UIImage? {
        didSet {
            if let image = iconImage {
                self.iconView.image = image
            }
        }
    }
    
    /// 确定点击事件
    public var determinClick: (() -> Void)?
    /// 取消点击事件
    public var cancelClick: (() -> Void)?
    /// 标题视图
    private var titleLabel: UILabel!
    /// 副标题视图
    private var subTitleLabel: UILabel!
    /// icon图标
    private var iconView: UIImageView!
    /// 确定按钮
    private var determineBtn: UIButton!
    /// 取消按钮
    private var cancelBtn: UIButton!
    /// 关闭按钮
    private var closeBtn: UIButton!
    
    public convenience init(type: MSPopupWindowType) {
        self.init(frame: .zero, type: type)
    }

    init(frame: CGRect, type: MSPopupWindowType) {
        super.init(frame: frame)
        switch type {
            case .AlertHideView:
                createAlertView(frame: frame)
            case .CloseAlertView:
                createCloseAlertView(frame: frame)
            case .ChooseAlertView:
                createChooseAlertView(frame: frame)
            case .DetermineAlertView:
                createDetermineAlertView(frame: frame)
        }
        self.backgroundColor = .hex("#FFFFFF")
        self.layer.cornerRadius = 24
        self.layer.shadowColor = UIColor.hex("#000000", 0.05).cgColor
        self.layer.shadowRadius = 30
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.opacity = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 创建视图方法
extension MSPopupWindowView {
    func createAlertView(frame: CGRect) {
        iconView = UIImageView()
        self.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.size.equalTo(CGSize(width: 64, height: 64))
        }
        
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
        }
    }
    
    func createCloseAlertView(frame: CGRect) {
        closeBtn = UIButton()
        self.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        closeBtn.setImage(UIImage(named: "common_alert_close"), for: .normal)
        
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeBtn.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
        }
        titleLabel.textAlignment = .center
        
        subTitleLabel = UILabel()
        self.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(39)
        }
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        
        determineBtn = UIButton()
        self.addSubview(determineBtn)
        determineBtn.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
        }
        determineBtn.layer.cornerRadius = 16
        determineBtn.layer.masksToBounds = true
    }
    
    func createChooseAlertView(frame: CGRect) {
        closeBtn = UIButton()
        self.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        closeBtn.setImage(UIImage(named: "common_alert_close"), for: .normal)
        
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeBtn.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
        }
        titleLabel.textAlignment = .center
        
        subTitleLabel = UILabel()
        self.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(39)
        }
        subTitleLabel.textAlignment = .center
        
        cancelBtn = UIButton()
        self.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(CGSize(width: 132, height: 48))
        }
        cancelBtn.layer.cornerRadius = 16
        cancelBtn.layer.masksToBounds = true
        
        determineBtn = UIButton()
        self.addSubview(determineBtn)
        determineBtn.snp.makeConstraints { make in
            make.top.equalTo(cancelBtn.snp.top).offset(0)
            make.left.equalTo(cancelBtn.snp.right).offset(15)
            make.size.equalTo(CGSize(width: 132, height: 48))
        }
        determineBtn.layer.cornerRadius = 16
        determineBtn.layer.masksToBounds = true
    }
    
    func createDetermineAlertView(frame: CGRect) {
        iconView = UIImageView()
        self.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(48)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 56, height: 56))
        }
        
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .hex("#000000")
        
        determineBtn = UIButton()
        self.addSubview(determineBtn)
        determineBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        determineBtn.layer.cornerRadius = 16
        determineBtn.layer.masksToBounds = true
    }
}

// MARK: - 公共UI方法
extension MSPopupWindowView {
    func setCommonUIStyle() {
        titleLabel.textAlignment = .center
        subTitleLabel.textAlignment = .center
    }
}
