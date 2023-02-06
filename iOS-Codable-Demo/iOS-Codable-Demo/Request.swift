//
//  Request.swift
//  iOS-Codable-Demo
//
//  Created by 王潇 on 2023/1/31.
//

import Foundation

enum HTTPMethods: String {
    case post = "POST"
    case get = "GET"
}

class Request {
    
    static let request = Request()
    
    func getData<O>(url: String, methond: HTTPMethods, dataType: O.Type, completion: @escaping (_ dataList: O) -> Void) where O: Decodable, O: Encodable {
        let session = URLSession(configuration: .default)
        
        if let url = URL(string: url) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = methond.rawValue
            
            /// POST请求新增
//            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            let postData = ["id": "xxxx", "name": "xxxx"]
//            let postString = postData.compactMap { (key, value) -> String in
//                return "\(key)=\(value)"
//            }.joined(separator: "&")
//            urlRequest.httpBody = postString.data(using: .utf8)
            
            let task = session.dataTask(with: urlRequest) { data, response, error in
                do {
                    if let data = data {
                        let newData = String(data: data, encoding: .utf8)?.data(using: .utf8)
                        let callbackData = try JSONDecoder().decode(dataType, from: newData!)
                        completion(callbackData)
                    }
                } catch {
                    print("无法连接到服务器")
                    return
                }
            }
            task.resume()
        }
    }
}
