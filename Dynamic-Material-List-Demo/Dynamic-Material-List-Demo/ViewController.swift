//
//  ViewController.swift
//  Dynamic-Material-List-Demo
//
//  Created by 王潇 on 2021/9/10.
//

import UIKit

class ViewController: UIViewController {

    var dynamicListView: DynamicListView!
    /// 最高值
    var upPointY: CGFloat = 0.0
    /// 滑动view中间判定值
    var middleY: CGFloat = 0.0
    /// 最低值
    var bottionY: CGFloat = 0.0
    /// 当前的Y值
    var currentY: CGFloat = 0.0
    /// 最大高度
    var maxtop: CGFloat = 80.0
    
    /// 最大高度
    let maxHiehgt: CGFloat = 315
    /// 最小的高度
    let minHeight: CGFloat = 215
    /// 记录向上滑动的值
    var yUpPoint: CGFloat = 0
    /// 记录向下滑动的值
    var yDownPoint: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicListView = DynamicListView()
        self.view.addSubview(dynamicListView)
        dynamicListView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-44)
            make.left.right.equalToSuperview()
            make.height.equalTo(215)
        }
        
        dynamicListView.scrollBack = { [weak self] scrollView in
            guard let self = self else {
                return
            }
            self.changeSize(scrollView: scrollView)
        }
    }
    
    func changeSize(scrollView: UIScrollView) {
        let height = self.dynamicListView.frame.size.height
        var result = height + scrollView.contentOffset.y
        var contentOffSetY: CGFloat = 0
        if result > self.maxHiehgt {
            contentOffSetY = result - maxHiehgt
            result = self.maxHiehgt
        } else if result < self.minHeight {
            contentOffSetY = result - minHeight
            result = self.minHeight
        }
        self.dynamicListView.snp.updateConstraints { make in
            make.height.equalTo(result)
        }
        
        let difference = maxHiehgt - minHeight
        
        if scrollView.contentOffset.y > 0 && yUpPoint <= difference {
            yUpPoint += scrollView.contentOffset.y
            scrollView.contentOffset.y = contentOffSetY
            if yUpPoint >= difference {
                yDownPoint = 0
            }
        } else if scrollView.contentOffset.y < 0 && yDownPoint >= -difference{
            yDownPoint += scrollView.contentOffset.y
            scrollView.contentOffset.y = contentOffSetY
            if yDownPoint <= -difference {
                yUpPoint = 0
            }
        }
    }

}

extension ViewController {
    /// 纪录最高值
    func countY() {
        upPointY = maxtop
        /// 滑动View中间判定值
        middleY = self.view.frame.size.height - maxtop / 2
        /// 最低值
        bottionY = self.view.frame.minY
        currentY = bottionY
    }
}

/// 添加手势
extension ViewController {
    
}

/// 事件
extension ViewController {
    
}
