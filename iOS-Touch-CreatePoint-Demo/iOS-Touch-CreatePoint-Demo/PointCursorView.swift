//
//  PointCursorView.swift
//  iOS-Touch-CreatePoint-Demo
//
//  Created by 王潇 on 2023/3/21.
//

import UIKit

class PointCursorView: UIView {
    
    private var touchesViewArray: [PointView] = []

    private let absTranslate: CGFloat = 60.0
    
    static let shared: PointCursorView = PointCursorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    static func showView() {
        guard let window = UIApplication.shared.connectedScenes
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows.first else { return }
        window.addSubview(PointCursorView.shared)
        PointCursorView.shared.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        isMultipleTouchEnabled = true
    }
    
    func pointViewTouchesBegan(point: CGPoint) {
        let pointView = PointView(frame: CGRect(x: point.x, y: point.y, width: PointView.pointWidth, height: PointView.pointHeight))
        touchesViewArray.append(pointView)
        addSubview(pointView)
        pointView.touchAnimation()
    }
    
    func pointViewTouchesMoved(point: CGPoint) {
        touchesViewArray.forEach({
            if abs($0.frame.origin.x - point.x) <= absTranslate && abs($0.frame.origin.y - point.y) <= absTranslate {
                if let index = touchesViewArray.firstIndex(of: $0) {
                    touchesViewArray[index].frame.origin = point
                    touchesViewArray[index].superview?.layoutIfNeeded()
                }
            }
        })
    }

    func pointViewTouchesEnded(point: CGPoint) {
        touchesViewArray.forEach({
            if abs($0.frame.origin.x - point.x) <= absTranslate && abs($0.frame.origin.y - point.y) <= absTranslate {
                $0.touchesDissmis()
                if let index = touchesViewArray.firstIndex(of: $0) {
                    touchesViewArray.remove(at: index)
                }
            }
        })
    }
}
