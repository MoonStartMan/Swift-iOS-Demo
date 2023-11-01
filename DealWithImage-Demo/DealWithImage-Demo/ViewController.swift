//
//  ViewController.swift
//  DealWithImage-Demo
//
//  Created by 王潇 on 2023/11/1.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    let kingfisherManager = KingfisherManager.shared
    
    let imageView: UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        //    Kingfisher是一个用于在Swift应用程序中加载和缓存图像的库。它提供了一种简单而强大的方式来从网络上下载图像，并在需要时进行缓存，以便在后续的请求中快速加载。

        //    Kingfisher的实现原理和步骤如下：

        //    1.创建一个KingfisherManager实例：KingfisherManager是Kingfisher库的核心类，用于管理图像的加载和缓存。你可以创建一个KingfisherManager实例来处理图像加载请求。

        //    2.发起图像加载请求：使用KingfisherManager实例的loadImage方法，你可以发起一个图像加载请求。你需要提供一个图像的URL和一个可选的占位图像，以便在图像加载完成之前显示。

        //    3.检查缓存：在发起网络请求之前，Kingfisher会首先检查本地缓存中是否存在已经下载的图像。如果存在缓存，Kingfisher将立即从缓存中获取图像并显示。

        //    4.下载图像：如果缓存中不存在图像，Kingfisher将使用URLSession发起一个网络请求来下载图像。下载的图像将被存储在内存缓存和磁盘缓存中。

        //    5.图像处理和显示：下载完成后，Kingfisher会对图像进行一些处理，例如调整大小、裁剪等。然后，它将图像显示在UIImageView或其他图像视图控件中。

        //    6.缓存管理：Kingfisher还提供了一些缓存管理的功能。你可以设置缓存的大小限制，以及清除过期的缓存。

        //  总结起来，Kingfisher的实现原理和步骤包括创建KingfisherManager实例、发起图像加载请求、检查缓存、下载图像、图像处理和显示以及缓存管理。这些步骤使得Kingfisher能够高效地加载和缓存图像，提供了方便易用的图像加载解决方案。

        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        guard let imageUrl = URL(string: "https://img1.baidu.com/it/u=3838700134,3936113726&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500") else { return }
        let placeholderImage = UIImage(named: "placeHolder")

        //  发起图像加载请求
        kingfisherManager.retrieveImage(with: imageUrl) { [weak self] result in
            switch result {
            case .success(let value):
                //  下载图像成功,将图像显示在UIImageView中
                self?.imageView.image = value.image
            case .failure(let error):
                //  图像加载失败
                print("Error: \(error)")
            }
        }

        //  检查缓存
        if let cachedImage = kingfisherManager.cache.retrieveImageInMemoryCache(forKey: imageUrl.cacheKey) {
            //  缓存中存在图像,直接显示
            imageView.image = cachedImage
        } else {
            //  缓存中不存在图像
            imageView.image = placeholderImage
        }

        //  缓存管理
        kingfisherManager.cache.diskStorage.config.sizeLimit = 100 * 1024 * 1024    //  设置磁盘缓存大小为100MB
        kingfisherManager.cache.clearMemoryCache() // 清除过期的磁盘缓存
    }
}

