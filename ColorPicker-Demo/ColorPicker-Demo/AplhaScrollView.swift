//
//  AplhaScrollView.swift
//  ColorPicker-Demo
//
//  Created by 王潇 on 2022/2/18.
//

import UIKit

class AplhaScrollView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    typealias aplhaBloack = (_ alphaValue: CGFloat) -> Void
    
    private var hueGradientLayer: CAGradientLayer = CAGradientLayer()
    
    private var coverView: UICollectionView!
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private var selectView: UIView = UIView()
    
    private var currentFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var currentAlpha: CGFloat = 0.0 {
        didSet {
            updatePosition(alpha: currentAlpha)
        }
    }
    
    var aplhaBack: aplhaBloack?

    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        
        coverView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        coverView.delegate = self
        coverView.dataSource = self
        coverView.register(AplhaItemCell.self, forCellWithReuseIdentifier: NSStringFromClass(AplhaItemCell.self))
        
        addSubview(selectView)
        selectView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(16)
        }
        selectView.layer.cornerRadius = 8
        selectView.layer.borderWidth = 2
        selectView.layer.borderColor = UIColor.white.cgColor
        selectView.backgroundColor = .clear
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(touchMove(pan:)))
        selectView.addGestureRecognizer(pan)
    }
    
    @objc func touchMove(pan: UIPanGestureRecognizer) {
        let location = pan.location(in: self)
        if pan.state == .changed {
            let x = location.x
            if x >= 0 && x <= currentFrame.size.width - 16 {
                selectView.snp.remakeConstraints { make in
                    make.width.height.equalTo(16)
                    make.left.equalToSuperview().offset(x)
                }
                currentAlpha = x / (currentFrame.size.width - 16)
                aplhaBack?(currentAlpha)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        hueGradientLayer.frame = self.bounds
        currentFrame = self.hueGradientLayer.frame
        layout.scrollDirection = .vertical
        let itemSize: CGSize = CGSize(width: currentFrame.size.height / 4, height: currentFrame.size.height / 4)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = itemSize
    }
    
    private func updatePosition(alpha: CGFloat) {
        let leftMargin = (currentFrame.size.width - 16) * alpha
        selectView.snp.remakeConstraints { make in
            make.width.height.equalTo(16)
            make.left.equalToSuperview().offset(leftMargin)
        }
    }
    
    func updateColor(color: UIColor) {
        hueGradientLayer.removeFromSuperlayer()
        var controls = [CGFloat]()
        controls = Array(stride(from: 0, through: 1, by: 0.1))
        hueGradientLayer.locations = controls as [NSNumber]?
        let hue = color.hsba.hue / 360
        hueGradientLayer.colors = controls.map {
            UIColor(hue: hue, saturation: 1, brightness: 1, alpha: $0).cgColor
        }
        hueGradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        hueGradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        coverView.layer.addSublayer(hueGradientLayer)
    }
    
}

extension AplhaScrollView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemHeight = currentFrame.size.height / 4
        let count = (currentFrame.size.width / itemHeight) * 4
        return Int(count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(AplhaItemCell.self), for: indexPath)
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        } else {
            cell.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.1)
        }
        return cell
    }
}

class AplhaItemCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
