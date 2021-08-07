//
//  ContentModel.swift
//  Swift-List-Demo
//
//  Created by 王潇 on 2021/8/7.
//

import Foundation

class ContentModel {
    //  总数
    var totalCount: Int = 0
    //  一行最多展示的个数
    let lineMaxcount: Int = 3
    //  照片总行数
    var totalRow: Int = 0
    //  最后一排照片列数
    var lastLineCount: Int = 0
    
    init(count: Int) {
        setModel(count: count)
    }
    
    convenience init() {
        self.init(count: 0)
    }
    
    func setModel(count: Int) {
        totalCount = count
        totalRow = Int(ceil(Double(totalCount) / Double(lineMaxcount)))
        lastLineCount = totalCount % lineMaxcount
    }
    
    func updateCount(count: Int) {
        setModel(count: count)
    }
}
