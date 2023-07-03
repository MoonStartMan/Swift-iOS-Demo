//
//  ViewController.swift
//  Swift-Cache-Demo
//
//  Created by 王潇 on 2023/5/24.
//

import UIKit

class ViewController: UIViewController {
    
    let networkManager: NetworkManager = NetworkManager()
    let cacheMangager: PTCacheManager = PTCacheManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchData()
    }
    
    private func processData(_ response: CacheFilter) {
        //  处理数据的实现
        let data = response.data
        //  ...
        print("\(data)")
    }
    
    private func fetchData() {
        //  1. 从本地加载数据
        
    }
    
    /// 从本地加载数据
    private func loadDataFromLocal() {
        guard networkManager.isReachable() else {
            //  处理无网络的情况
            if let cacheData: CacheFilter = cacheMangager.loadDataFormFile(fileName: "filterList.json", returnType: CacheFilter.self) {
                //  使用缓存数据加载
                
            } else {
                //  没有缓存数据,无网络连接,可以进行相应的处理
                
            }
            return
        }
    }
    
    /// 检测是否有更新
    private func checkUpdate() {
        networkManager.fetchDataFromNetwork(urlString: "http://119.23.65.167:9101/xiao/v1/had-updated") { [weak self] (response: CacheUpdate?, error) in
            guard let self = self else { return }
            
            if let error = error {
                /// 处理网络请求错误的情况
                print("网络请求错误: \(error)")
                return
            }
            
            if let response = response {
                if response.state == "success" {
                    if response.data.updated {
                        /// 有更新
                    } else {
                        /// 没有更新
                    }
                }
            }
        }
    }
    
    /// 获取滤镜列表
    private func getFilterList() {
        networkManager.fetchDataFromNetwork(urlString: "http://119.23.65.167:9101/xiao/v1/get-filter") { [weak self] (response: CacheFilter?, error) in
            guard let self = self else { return }

            if let error = error {
                //  处理网络请求错误的情况
                print("网络请求错误: \(error)")
                return
            }

            if let response = response {
                //  处理网络请求成功的情况
                self.processData(response)
                self.cacheMangager.saveDataToFile(fileName: "filterList.json", data: response)
            }
        }
    }
}

