//
//  MovingView.swift
//  MovingViewDemo
//
//  Created by 王潇 on 2022/9/12.
//

import UIKit

enum MovingDirectionType {
    case left
    case right
    case bottom
    case top
}

enum SpeedType {
    /// 长文字慢,短文字快
    case special
    /// 不根据文字长短,都是匀速
    case normal
}

protocol MovingViewProtocol {
    func drawMarqueeView(drawMarqueeView: MovingView, animationDidStopFinished: Bool) -> Void
}

class MovingView: UIView, CAAnimationDelegate {
    /// 速度
    var speed: Float = 1.0
    /// 宽
    var width: Float = 0.0
    /// 高
    var height: Float = 0.0
    /// 动画视图宽
    var animationViewWidth: Float = 0.0
    /// 动画视图高
    var animationViewHeight: Float = 0.0
    /// 是否停止
    var stop: Bool = true
    /// 方向
    var moveType: MovingDirectionType = .left
    /// 速度类型
    var speedType: SpeedType = .special
    /// 内容
    var contentView: UIView = UIView()
    /// 动画视图
    var animationView: UIView = UIView()
    /// 协议
    var delegate: MovingViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        width = Float(frame.size.width)
        height = Float(frame.size.height)
        speed = 1
        layer.masksToBounds = true
        moveType = .left
        animationView = UIView(frame: CGRect())
        addSubview(animationView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 添加Content试图
    func addContentView(view: UIView) -> Void {
        contentView.removeFromSuperview()
        view.frame = view.bounds
        contentView = view
        animationView.frame = view.bounds
        animationView.addSubview(contentView)
        /// 内部空间W
        animationViewWidth = Float(animationView.frame.size.width)
        /// 内部空间H
        animationViewHeight = Float(animationView.frame.size.height)
    }
    
    /// 开始动画
    func startAnimation() -> Void {
        animationView.layer.removeAnimation(forKey: "animationViewPosition")
        stop = false
        /// 右边的中心
        let pointRightCenter = CGPoint.init(x: Int(width + animationViewWidth / 2), y: Int(animationViewHeight) / 2)
        /// 左边的中信
        let pointLeftCenter = CGPoint.init(x: -Int(animationViewWidth / 2), y: Int(animationViewHeight) / 2)
        /// 下中心
        let pointBottomCenter = CGPoint.init(x: Int(animationViewWidth / 2), y: Int(animationViewHeight) / 2 + Int(height))
        /// 上中心
        let pointUpCenter = CGPoint.init(x: Int(animationViewWidth) / 2, y: -Int(animationViewHeight) / 2)
        var fromPoint = CGPoint.init()
        var toPoint = CGPoint.init()
        switch moveType {
        case .left:
            fromPoint = pointRightCenter
            toPoint = pointLeftCenter
        case .right:
            fromPoint = pointLeftCenter
            toPoint = pointRightCenter
        case .bottom:
            fromPoint = pointBottomCenter
            toPoint = pointUpCenter
        case .top:
            fromPoint = pointUpCenter
            toPoint = pointBottomCenter
        }
        
        animationView.center = fromPoint
        let movePath = UIBezierPath.init()
        movePath.move(to: fromPoint)
        movePath.addLine(to: toPoint)
        
        let moveAnimation = CAKeyframeAnimation.init(keyPath: "position")
        moveAnimation.path = movePath.cgPath
        moveAnimation.isRemovedOnCompletion = true
        
        if self.speedType == .special {
            moveAnimation.duration = CFTimeInterval(animationViewWidth / 30 * (1 / speed))
        }
        
        if self.speedType == .normal {
            moveAnimation.duration = CFTimeInterval(2 * (1 / speed))
        }
        
        moveAnimation.delegate = self
        animationView.layer.add(moveAnimation, forKey: "animationViewPosition")
    }
    
    /// 停止动画
    func stopAnimation() -> Void {
        stop = true
        animationView.layer.removeAnimation(forKey: "animationViewPosition")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        delegate?.drawMarqueeView(drawMarqueeView: self, animationDidStopFinished: flag)
        if flag && !stop {
            self.startAnimation()
        }
    }
    
    /// 暂停
    func pauseAnimation() -> Void {
        let layer = animationView.layer
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0
        layer.timeOffset = pausedTime
    }
    
    /// 重启Swift
    func resumeAnimation() -> Void {
        let layer = animationView.layer
        let pausedTime = layer.timeOffset
        layer.speed = 1
        layer.timeOffset = 0
        layer.beginTime = 0
        let timeSincePause = layer .convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
}
