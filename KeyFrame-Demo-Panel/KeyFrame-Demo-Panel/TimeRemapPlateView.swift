//
//  TimeRemapPlateView.swift
//  KeyFrame-Demo-Panel
//
//  Created by 王潇 on 2023/4/7.
//

import UIKit
import SnapKit

class TimeRemapPlateView: UIView {
    
    private var coverView: UIView = UIView()
    
    private var lineView: UIView = UIView()
    
    private var timeCoverView: UIView = UIView()
    
    private var timeCoverLabel: UILabel = UILabel()

    private var originTimeLabel: UILabel = UILabel()
    
    private var swapTimeIcon: UIImageView = UIImageView()
    
    private var variationTimeLabel: UILabel = UILabel()
    
    private var curveBtn: MSListBtn = MSListBtn()
    
    private var resetBtn: MSListBtn = MSListBtn()
    
    private var keyFrameBtn: UIButton = UIButton()
    
    private var prevFrameBtn: MSListBtn = MSListBtn()
    
    private var decideFrameBtn: MSListBtn = MSListBtn()
    
    private var nextFrameBtn: MSListBtn = MSListBtn()
    
    weak var delegate: TimeRemapPlateViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(276)
        }
        
        coverView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        lineView.backgroundColor = .hex("#000000", 0.06)
        
        coverView.addSubview(timeCoverView)
        timeCoverView.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(64)
        }
        timeCoverView.layer.borderWidth = 1.0
        timeCoverView.layer.borderColor = UIColor.hex("#000000", 0.06).cgColor
        timeCoverView.layer.cornerRadius = 8
        timeCoverView.layer.masksToBounds = true
        timeCoverView.backgroundColor = .hex("#F7F7F7")
        
        timeCoverView.addSubview(timeCoverLabel)
        timeCoverLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        timeCoverLabel.textColor = .hex("#1A1A1A")
        timeCoverLabel.font = .systemFont(ofSize: 12.0)
        timeCoverLabel.text = "00:00:00"
        
        coverView.addSubview(originTimeLabel)
        originTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.centerY.equalTo(timeCoverView.snp.centerY)
        }
        originTimeLabel.font = .systemFont(ofSize: 12.0)
        originTimeLabel.textColor = .hex("#1A1A1A")
        originTimeLabel.text = "7.00s"
        
        coverView.addSubview(swapTimeIcon)
        swapTimeIcon.snp.makeConstraints { make in
            make.left.equalTo(originTimeLabel.snp.right).offset(2)
            make.centerY.equalTo(timeCoverView.snp.centerY)
            make.width.height.equalTo(9)
        }
        swapTimeIcon.image = UIImage(named: "time_edit_replace")
        
        coverView.addSubview(variationTimeLabel)
        variationTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(swapTimeIcon.snp.right).offset(2)
            make.centerY.equalTo(timeCoverView.snp.centerY)
        }
        variationTimeLabel.font = .systemFont(ofSize: 12.0)
        variationTimeLabel.textColor = .hex("#1A1A1A")
        variationTimeLabel.text = "7.00s"
        
        coverView.addSubview(curveBtn)
        curveBtn.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.right.equalTo(-16)
            make.width.height.equalTo(40)
        }
        curveBtn.imageName = "icon_edit_curv"
        curveBtn.layer.borderColor = UIColor.hex("#000000", 0.06).cgColor
        curveBtn.layer.borderWidth = 1
        curveBtn.layer.cornerRadius = 12
        curveBtn.addAction(for: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            self.delegate?.curveBtnClick()
        }
        curveBtn.isUserInteractionEnabled = false
        
        coverView.addSubview(resetBtn)
        resetBtn.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.right.equalTo(curveBtn.snp.left).offset(-8)
            make.width.height.equalTo(40)
        }
        resetBtn.imageName = "curve_speed_reset"
        resetBtn.layer.borderColor = UIColor.hex("#000000", 0.06).cgColor
        resetBtn.layer.cornerRadius = 12
        resetBtn.layer.borderWidth = 1
        resetBtn.addAction(for: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            self.delegate?.resetBtnClick()
        }
        resetBtn.isUserInteractionEnabled = false
        
        coverView.addSubview(keyFrameBtn)
        keyFrameBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(216)
            make.height.equalTo(48)
            make.top.equalTo(timeCoverView.snp.bottom).offset(56)
        }
        keyFrameBtn.backgroundColor = .hex("#1A1A1A")
        keyFrameBtn.layer.cornerRadius = 12
        keyFrameBtn.layer.masksToBounds = true
        keyFrameBtn.setImage(UIImage(named: "time_edit_add_keyframe"), for: .normal)
        keyFrameBtn.setTitle("添加关键帧", for: .normal)
        keyFrameBtn.semanticContentAttribute = .forceLeftToRight
        keyFrameBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        keyFrameBtn.titleLabel?.font = .systemFont(ofSize: 12.0)
        keyFrameBtn.addAction(for: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            self.delegate?.keyFrameBtnClick()
        }
        
        coverView.addSubview(prevFrameBtn)
        prevFrameBtn.snp.makeConstraints { make in
            make.left.equalTo(keyFrameBtn.snp.left)
            make.width.height.equalTo(40)
            make.top.equalTo(keyFrameBtn.snp.bottom).offset(16)
        }
        let prevImage = UIImage(named: "time_edit_prev_keyfame")?.withRenderingMode(.alwaysTemplate)
        prevFrameBtn.setImage(prevImage, for: .normal)
        prevFrameBtn.layer.cornerRadius = 12
        prevFrameBtn.layer.borderColor = UIColor.hex("#000000", 0.06).cgColor
        prevFrameBtn.layer.borderWidth = 1
        prevFrameBtn.tintColor = .hex("#1A1A1A")
        prevFrameBtn.addAction(for: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            self.delegate?.prevFrameBtnClick()
        }
        
        coverView.addSubview(nextFrameBtn)
        nextFrameBtn.snp.makeConstraints { make in
            make.right.equalTo(keyFrameBtn.snp.right)
            make.width.height.equalTo(40)
            make.top.equalTo(keyFrameBtn.snp.bottom).offset(16)
        }
        let nextImage = UIImage(named: "time_edit_next_keyfame")?.withRenderingMode(.alwaysTemplate)
        nextFrameBtn.setImage(nextImage, for: .normal)
        nextFrameBtn.layer.cornerRadius = 12
        nextFrameBtn.layer.borderColor = UIColor.hex("#000000", 0.06).cgColor
        nextFrameBtn.layer.borderWidth = 1
        nextFrameBtn.tintColor = .hex("#1A1A1A")
        nextFrameBtn.addAction(for: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            self.delegate?.nextFrameBtnClick()
        }
        
        coverView.addSubview(decideFrameBtn)
        decideFrameBtn.snp.makeConstraints { make in
            make.left.equalTo(prevFrameBtn.snp.right).offset(8)
            make.right.equalTo(nextFrameBtn.snp.left).offset(-8)
            make.top.equalTo(keyFrameBtn.snp.bottom).offset(16)
            make.height.equalTo(40)
        }
        let decideImage = UIImage(named: "time_edit_decide_keyfame")?.withRenderingMode(.alwaysTemplate)
        decideFrameBtn.setImage(decideImage, for: .normal)
        decideFrameBtn.setTitle("定格关键帧", for: .normal)
        decideFrameBtn.setTitleColor(.hex("#1A1A1A"), for: .normal)
        decideFrameBtn.titleLabel?.font = .systemFont(ofSize: 12.0)
        decideFrameBtn.layer.cornerRadius = 12
        decideFrameBtn.layer.borderColor = UIColor.hex("#000000", 0.06).cgColor
        decideFrameBtn.layer.borderWidth = 1
        decideFrameBtn.semanticContentAttribute = .forceLeftToRight
        decideFrameBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        decideFrameBtn.tintColor = .hex("#1A1A1A")
        decideFrameBtn.addAction(for: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            self.delegate?.decideFrameBtnClick()
        }
        
        updateBtnState(isFirst: false, isDecide: false, isLast: false)
        updateDecideBtn(isSet: true)
    }
    
}

extension TimeRemapPlateView {
    // 更新转换时长
    /// originTime: 原始时长 variationTime: 转换后的时长
    func updateConversionTime(originTime: String, variationTime: String) {
        originTimeLabel.text = originTime
        variationTimeLabel.text = variationTime
    }
    
    //  更新视频时长
    /// originTime: 视频在工程的时长
    func updateProjectTime(originTime: String) {
        timeCoverLabel.text = originTime
    }
    
    //  更新关键帧状态(添加/删除)
    /// isAdd: 是否为添加关键帧
    func updateKeyFrameBtnState(isAdd: Bool) {
        if isAdd {
            keyFrameBtn.setTitle("添加关键帧", for: .normal)
            keyFrameBtn.setImage(UIImage(named: "time_edit_add_keyframe"), for: .normal)
        } else {
            keyFrameBtn.setTitle("删除关键帧", for: .normal)
            keyFrameBtn.setImage(UIImage(named: "time_edit_delete_keyframe"), for: .normal)
        }
    }
    
    // 更新曲线/重置按钮状态
    /// curveState: 曲线按钮状态 resetState: 重置按钮状态
    func updateCurveRestBtn(curveState: Bool, resetState: Bool) {
        curveBtn.isUserInteractionEnabled = curveState
        resetBtn.isUserInteractionEnabled = resetState
    }
    
    // 更新/上一帧/定格帧/下一帧的状态
    /// isFirst: 上一帧状态 isDecide: 定格帧状态 isLast: 下一帧状态
    func updateBtnState(isFirst: Bool, isDecide: Bool, isLast: Bool) {
        prevFrameBtn.isUserInteractionEnabled = isFirst
        decideFrameBtn.isUserInteractionEnabled = isDecide
        nextFrameBtn.isUserInteractionEnabled = isLast
        prevFrameBtn.tintColor = isFirst ? .hex("#1A1A1A") : .hex("#C7C7C7")
        decideFrameBtn.tintColor = isDecide ? .hex("#1A1A1A") : .hex("#C7C7C7")
        decideFrameBtn.setTitleColor(isDecide ? .hex("#1A1A1A") : .hex("#C7C7C7"), for: .normal)
        nextFrameBtn.tintColor = isLast ? .hex("#1A1A1A") : .hex("#C7C7C7")
    }
    
    // 更新定格帧
    /// isSet: true ---> 已经设置 展示 "取消定格帧" 同理 false
    func updateDecideBtn(isSet: Bool) {
        decideFrameBtn.setTitle(!isSet ? "定格帧" : "取消定格帧", for: .normal)
    }
}
