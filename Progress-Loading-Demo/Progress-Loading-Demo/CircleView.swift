//
//  CircleView.swift
//  Progress-Loading-Demo
//
//  Created by 王潇 on 2021/9/6.
//

import UIKit

class CircleView: UIView {
    /// 进度
    var progress: CGFloat = 0
    /// 进度条颜色
    var progerssColor: UIColor = .systemBlue {
        didSet {
            self.progerssColor.set()
        }
    }
    /// 进度条背景颜色
    var progerssBackgroundColor: UIColor = .systemBlue {
        didSet {
            self.progerssBackgroundColor.set()
        }
    }
    
    /// 进度条的宽度
    var progerWidth: CGFloat = 5  {
        didSet {
            backgroundPath.lineWidth = progerWidth
            progressPath.lineWidth = progerWidth
        }
    }
    /// 是否展示label
    var showLabel: Bool = false {
        didSet {
            if showLabel {
                percentLabel.isHidden = false
            } else {
                percentLabel.isHidden = true
            }
        }
    }
    /// 进数条字体大小
    var percentageFontSize: CGFloat = 16
    /// 进度数字颜色
    var percentFontColor: UIColor = .systemBlue
    /// 百分比标签
    private var percentLabel: UILabel!
    /// 背景Path
    private var backgroundPath: UIBezierPath!
    /// 进度Path
    private var progressPath: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        /// 百分比标签
        percentLabel = UILabel()
        self.addSubview(percentLabel)
        percentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        percentLabel.font = .systemFont(ofSize: percentageFontSize)
        percentLabel.textColor = percentFontColor
        percentLabel.textAlignment = .center
        percentLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProgress(progress: CGFloat) {
        self.progress = progress
        percentLabel.text = "\(Int(floor(self.progress)))"
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        /// 路径
        backgroundPath = UIBezierPath()
        /// 线宽
        backgroundPath.lineWidth = self.progerWidth
        /// 颜色
        self.progerssBackgroundColor.set()
        /// 拐角
        backgroundPath.lineCapStyle = .round
        backgroundPath.lineJoinStyle = .round
        /// 半径
        let radius = (min(rect.size.width, rect.size.height) - progerWidth) * 0.5
        /// 画弧
        backgroundPath.addArc(withCenter: (CGPoint)(x: rect.size.width * 0.5, y:rect.size.height * 0.5), radius: radius, startAngle: CGFloat(Double.pi * 1.5), endAngle: CGFloat(Double.pi * 1.5 + Double.pi * 2), clockwise: true)
        /// 连线
        backgroundPath.stroke()
        
        /// 路径
        progressPath = UIBezierPath()
        /// 线宽
        progressPath.lineWidth = self.progerWidth
        /// 颜色
        self.progerssColor.set()
        /// 拐角
        progressPath.lineCapStyle = .round
        progressPath.lineJoinStyle = .round
        /// 画弧
        progressPath.addArc(withCenter: (CGPoint)(x: rect.size.width * 0.5, y: rect.size.height * 0.5), radius: radius, startAngle: CGFloat(Double.pi * 1.5), endAngle: CGFloat(Double.pi * 1.5 + Double.pi * 2 * Double(progress / 100)), clockwise: true)
        /// 连线
        progressPath.stroke()
    }
}
