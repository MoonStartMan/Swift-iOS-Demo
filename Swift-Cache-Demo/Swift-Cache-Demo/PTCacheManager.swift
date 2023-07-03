//
//  PTCacheManger.swift
//  Swift-Cache-Demo
//
//  Created by 王潇 on 2023/5/24.
//

import Foundation

class PTCacheManager: NSObject {
    
    private let fileManager = FileManager.default
    
    private func getDocumentDirectory() -> URL? {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    private func getCacheFilePath(fileName: String) -> URL? {
        guard let documentDirectory = getDocumentDirectory() else {
            return nil
        }
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    func saveDataToFile<T>(fileName: String, data: T) where T:Encodable {
        if let fileURL = getCacheFilePath(fileName: fileName) {
            do {
                let encodedData = try JSONEncoder().encode(data)
                try encodedData.write(to: fileURL)
                print("数据已保存到本地文件")
            } catch {
                print("存储失败: \(error)")
            }
        } else {
            print("无法获取文件路径")
        }
    }
    
    func loadDataFormFile<T: Decodable>(fileName: String, returnType: T.Type) -> T? {
        if let fileURL = getCacheFilePath(fileName: fileName) {
            do {
                let data = try Data(contentsOf: fileURL)
                print("成功从文件加载数据: \(fileURL)")
                let decodedData = try JSONDecoder().decode(returnType, from: data)
                return decodedData
            } catch {
                print("加载数据失败: \(error)")
                return nil
            }
        } else {
            print("无法获取文件路径")
            return nil
        }
    }
}

class CacheFilter: Codable {
    var state: String
    var data: [CacheFilterData]
    
    init(state: String, data: [CacheFilterData]) {
        self.state = state
        self.data = data
    }
}

class CacheFilterData: Codable {
    var id: String
    var name: String
    var pic: String
    var type: String
    var fileUrl: String
    
    init(id: String, name: String, pic: String, type: String, fileUrl: String) {
        self.id = id
        self.name = name
        self.pic = pic
        self.type = type
        self.fileUrl = fileUrl
    }
}

class CacheUpdate: Codable {
    var state: String
    var data: ChacheUpdateData
    
    init(state: String, data: ChacheUpdateData) {
        self.state = state
        self.data = data
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let data = dictionary["data"] as? ChacheUpdateData,
              let state = dictionary["state"] as? String else {
            return nil
        }
        self.init(state: state, data: data)
    }
}

class ChacheUpdateData: Codable {
    var updated: Bool
    
    init(updated: Bool) {
        self.updated = updated
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let updated = dictionary["updated"] as? Bool else {
            return nil
        }
        self.init(updated: updated)
    }
}
