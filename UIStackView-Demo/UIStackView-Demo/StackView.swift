//
//  StackView.swift
//  UIStackView-Demo
//
//  Created by 王潇 on 2023/2/18.
//

import UIKit

//protocol SwipeableCollectionViewCellDelegate: AnyObject {
//    func visibleContainerViewTapped(inCell cell: UICollectionViewCell)
//    func hiddenContainerViewTapped(inCell cell: UICollectionViewCell)
//}

class SwipeableCollectionViewCell: UIView, UIScrollViewDelegate {
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private var stackView: UIStackView = UIStackView()
    
    private var visibleContainerView: UIView = UIView()
    
    private var hiddenContainerView: UIView = UIView()
    
//    weak var delegate: SwipeableCollectionViewCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        /// 设置UIStackView布局的方向: 水平方向或垂直方向
        stackView.axis = .horizontal
        
        /// 设置非轴方向子视图的对齐方式
        /// UIStackViewAlignmentFill:  // 子视图填充
        /// UIStackViewAlignmentLeading:  // 子视图左对齐（axis为垂直方向而言）
        /// UIStackViewAlignmentTop = UIStackViewAlignmentLeading:  // 子视图顶部对齐（axis为水平方向而言）
        /// UIStackViewAlignmentFirstBaseline:  // 按照第一个子视图的文字的第一行对齐，同时保证高度最大的子视图底部对齐（只在axis为水平方向有效）
        /// UIStackViewAlignmentCenter: // 子视图居中对齐
        /// UIStackViewAlignmentTrailing: // 子视图右对齐(axis为垂直方向而言）
        /// UIStackViewAlignmentBottom = UIStackViewAlignmentTrailing: // 子视图底部对齐（axis为水平方向而言）
        /// UIStackViewAlignmentLastBaseline:  // 按照最后一个子视图的文字的最后一行对齐，同时保证高度最大的子视图顶部对齐（只在axis为水平方向有效）
//        stackView.alignment = .fill
        
        /// 设置轴方向上子视图的分布比例(如果axis是水平方向,也即设置子视图的宽度,如果axis是垂直方向,则是设置子视图的高度)
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(visibleContainerView)
        stackView.addArrangedSubview(hiddenContainerView)
        
        visibleContainerView.backgroundColor = .systemMint
        hiddenContainerView.backgroundColor = .systemPink
        
        addSubview(scrollView)
        scrollView.pinEdgesToSuperView()
        scrollView.delegate = self
        scrollView.addSubview(stackView)
        stackView.pinEdgesToSuperView()
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 2).isActive = true
    }
    
//    @objc private func visibleContainerViewTapped() {
//        delegate?.visibleContainerViewTapped(inCell: self)
//    }
//
//    @objc private func hiddenContainerViewTapped() {
//        delegate?.hiddenContainerViewTapped(inCell: self)
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("\(scrollView.frame.size.width)")
        
        print("\(scrollView.contentOffset.x)")
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        print("滑动结束")
//
//        if scrollView.contentOffset.x < scrollView.frame.size.width / 2.0 {
//            scrollView.contentOffset.x = 0
//        } else {
//            scrollView.contentOffset.x = scrollView.frame.size.width
//        }
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x < scrollView.frame.size.width / 2.0 {
            scrollView.contentOffset.x = 0
        } else {
            scrollView.contentOffset.x = scrollView.frame.size.width
        }
    }
}

extension UIView {
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}
