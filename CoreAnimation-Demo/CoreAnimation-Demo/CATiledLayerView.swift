//
//  CATTiledLayerView.swift
//  CoreAnimation-Demo
//
//  Created by 王潇 on 2023/3/9.
//

import UIKit

class CATiledLayerView: UIView {
    
    private var scrollView: UIScrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        testTiledLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func testTiledLayer() {
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let titleLayer = CATiledLayer()
        titleLayer.frame = CGRect(x: 0, y: 0, width: 2048, height: 2048)
        titleLayer.delegate = self
        scrollView.layer.addSublayer(titleLayer)
        scrollView.contentSize = titleLayer.frame.size
        titleLayer.setNeedsDisplay()
    }
    
}

extension CATiledLayerView {
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        guard let layer = layer as? CATiledLayer else {
            return
        }
        
        //  Determine tile coordinate
        let bounds = ctx.boundingBoxOfClipPath
        let x: Int = Int(floor(bounds.origin.x / layer.tileSize.width))
        let y: Int = Int(floor(bounds.origin.y / layer.tileSize.height))
        
        //  Load tile image
        let imgName = "scenery_0\(x)_0\(y)"
        let imgPath = Bundle.main.path(forResource: "scenery", ofType: "jpg")
        guard let imgLocation = imgPath else { return }
        let tileImage = UIImage(contentsOfFile: imgLocation)
        
        UIGraphicsPushContext(ctx)
        tileImage?.draw(in: bounds)
        UIGraphicsPopContext()
    }
}
