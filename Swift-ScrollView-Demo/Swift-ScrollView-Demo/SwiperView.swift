//
//  SwiperView.swift
//  Swift-ScrollView-Demo
//
//  Created by 王潇 on 2022/6/4.
//

import UIKit
import SnapKit

private let kWidth: CGFloat = UIScreen.main.bounds.size.width
private let kHeight: CGFloat = UIScreen.main.bounds.size.height

class SwiperView: UIView, UIScrollViewDelegate {
    
    private var pageControl: UIPageControl = UIPageControl()
    private var scrollView: UIScrollView = UIScrollView()
    private var timer: Timer?
    private lazy var colorArray: [UIColor] = [
        UIColor.systemCyan,
        UIColor.systemBrown,
        UIColor.systemPink
    ]
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: kWidth * CGFloat(colorArray.count), height: kHeight)
        
        for (index, item) in colorArray.enumerated() {
            let fontView = UIView()
            scrollView.addSubview(fontView)
            fontView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.height.equalTo(kHeight)
                make.width.equalTo(kWidth)
                make.left.equalToSuperview().offset(CGFloat(Int(kWidth) * index))
            }
            fontView.backgroundColor = item
        }
        
        addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-34)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        pageControl.numberOfPages = colorArray.count
    }
}

extension SwiperView {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x: CGFloat = scrollView.contentOffset.x
        let scrollW: CGFloat = scrollView.frame.size.width
        let page: Int = (Int)((x + scrollW / 2) / scrollW)
        pageControl.currentPage = page
    }
}
