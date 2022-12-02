//
//  IntroducerView.swift
//  Introducer-page-demo
//
//  Created by 王潇 on 2022/10/22.
//

import UIKit
import AVFoundation
import SnapKit

class IntroducerView: UIView {
    
    private var player: AVPlayerLayer?
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private var videoView: UICollectionView!
    
    private var coverView: UIView = UIView()
    
    private var navigationLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private var navigationView: UICollectionView!
    
    private var startContentOffSetX: CGFloat = 0.0
    
    private var willEndContentOffsetX: CGFloat = 0.0
    
    private var endContentOffsetX: CGFloat = 0.0
    
    var playIndex: Int = 0 {
        didSet {
            removePromotionalVideo()
            addPromotionalVideo(fileName: "\(playIndex + 1)")
            setContentOffsetX(playIndex: CGFloat(playIndex))
//            guard let videoCell = videoView.cellForItem(at: IndexPath(item: playIndex, section: 0)) as? IntroducerCell else { return }
//            videoCell.showAnimationView()
            navigationView.reloadData()
            videoView.reloadData()
        }
    }
    
    private lazy var dataArray: [IntroduceItemModel] = {
        return [
            IntroduceItemModel(title: "图层轨道自由排列", content: "轨道混排模式，带给你无限创作能力最多两排文案", videoName: "1", active: false),
            IntroduceItemModel(title: "图层单独K关键帧", content: "轨道混排模式，带给你无限创作能力最多两排文案", videoName: "2", active: false),
            IntroduceItemModel(title: "自由编辑特效&参数", content: "轨道混排模式，带给你无限创作能力最多两排文案", videoName: "3", active: true)
        ]
    }()
    
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
            make.edges.equalToSuperview()
        }
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        videoView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(videoView)
        videoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        videoView.showsHorizontalScrollIndicator = false
        videoView.showsVerticalScrollIndicator = false
        videoView.delegate = self
        videoView.dataSource = self
        videoView.isPagingEnabled = true
        videoView.contentInsetAdjustmentBehavior = .never
        videoView.backgroundColor = .clear
        videoView.register(IntroducerCell.self, forCellWithReuseIdentifier: NSStringFromClass(IntroducerCell.self))
        
        navigationLayout.estimatedItemSize = CGSize(width: 8, height: 8)
        navigationLayout.scrollDirection = .horizontal
        navigationView = UICollectionView(frame: .zero, collectionViewLayout: navigationLayout)
        navigationView.showsVerticalScrollIndicator = false
        navigationView.showsHorizontalScrollIndicator = false
        navigationView.isScrollEnabled = false
        navigationView.delegate = self
        navigationView.dataSource = self
        navigationView.backgroundColor = .clear
        navigationView.register(IntroducerNavigationCell.self, forCellWithReuseIdentifier: NSStringFromClass(IntroducerNavigationCell.self))
        
        addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-136)
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
        playIndex = 0
    }
}

extension IntroducerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == videoView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(IntroducerCell.self), for: indexPath) as? IntroducerCell else {
                fatalError()
            }
            cell.model = dataArray[indexPath.item]
            cell.clickBtnBack = { [weak self] in
                guard let self = self else { return }
                if self.playIndex < self.dataArray.count - 1 {
                    self.playIndex += 1
                }
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(IntroducerNavigationCell.self), for: indexPath) as? IntroducerNavigationCell else {
                fatalError()
            }
            if playIndex == indexPath.item {
                cell.active = true
            } else {
                cell.active = false
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == navigationView {
            let totalCount = dataArray.count
            let margin: CGFloat = 10.0
            let itemWidth: CGFloat = 8.0
            let totalWidth = CGFloat(totalCount) * itemWidth + CGFloat(totalCount - 1) * margin
            let insetsMargin: CGFloat = (UIScreen.main.bounds.size.width - totalWidth) / 2.0
            return UIEdgeInsets(top: 0, left: insetsMargin, bottom: 0, right: insetsMargin)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            let contentOffsetX = scrollView.contentOffset.x
            let kScreenW = UIScreen.main.bounds.size.width
            let currentIndex = Int(ceil(contentOffsetX / kScreenW))
            if currentIndex == playIndex || currentIndex >= dataArray.count {
                return
            } else {
                if let videoCell = videoView.cellForItem(at: IndexPath(item: currentIndex, section: 0)) as? IntroducerCell {
                    videoCell.showAnimationView()
                }
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startContentOffSetX = scrollView.contentOffset.x
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        willEndContentOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        endContentOffsetX = scrollView.contentOffset.x
        
        if endContentOffsetX < willEndContentOffsetX && willEndContentOffsetX < startContentOffSetX {
            if playIndex > 0 {
                playIndex -= 1
            }
        } else if endContentOffsetX > willEndContentOffsetX && willEndContentOffsetX > startContentOffSetX {
            if playIndex < dataArray.count {
                playIndex += 1
            }
        }
    }
    
    func addPromotionalVideo(fileName: String) {
        if let filePath = Bundle.main.path(forResource: fileName, ofType: "mp4") {
            let videoUrl = URL(fileURLWithPath: filePath)
            let playerItem = AVPlayerItem(url: videoUrl)
            let avplayer = AVPlayer(playerItem: playerItem)
            player = AVPlayerLayer(player: avplayer)
            player?.frame = UIScreen.main.bounds
            player?.videoGravity = .resizeAspectFill
            if let player = player {
                coverView.layer.addSublayer(player)
            }
            avplayer.play()
        }
    }
    
    func setContentOffsetX(playIndex: CGFloat) {
        videoView.contentOffset.x = playIndex * UIScreen.main.bounds.size.width
    }
    
    func removePromotionalVideo() {
        player?.removeFromSuperlayer()
    }
}
