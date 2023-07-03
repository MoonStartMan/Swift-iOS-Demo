//
//  NetWorkManager.swift
//  Swift-Cache-Demo
//
//  Created by 王潇 on 2023/6/19.
//

import Foundation
import Network

class NetworkManager {
    private let monitor = NWPathMonitor()
    private var isNetworkAvailable: Bool = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            self.isNetworkAvailable = path.status == .satisfied
        }
        
        let queue = DispatchQueue(label: "NetworkReachabilityQueue")
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
    
    func isReachable() -> Bool {
        return isNetworkAvailable
    }
    
    func fetchDataFromNetwork<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        if isReachable() {
            guard let url = URL(string: urlString) else {
                return
            }
            
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Content-Type": "application/json"]
            config.timeoutIntervalForRequest = 30
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            let session = URLSession(configuration: config)
            session.dataTask(with: urlRequest) { data, _, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                if let resultData = data {
                    // 处理获取到的数据
                    do {
                        let jsonDecoder = JSONDecoder()
                        let decodeObject = try jsonDecoder.decode(T.self, from: resultData)
                        completion(decodeObject, nil) // 返回模型对象
                    } catch {
                        completion(nil, error)
                    }
                }
            }.resume()
        }
    }
}
