//
//  ResolutionMultipleModel.swift
//  swift-drawer-menu-demo
//
//  Created by 王潇 on 2022/10/17.
//

import Foundation

enum ResolutionMultipleType {
    /// 完整
    case full
    /// 二分之一
    case half
    /// 四分之一
    case quarter
    /// 八分之一
    case eighth
}

class ResolutionMultipleModel {
    var title: String
    var type: ResolutionMultipleType
    var isSelect: Bool
    var isCheck: Bool
    
    init(title: String, type: ResolutionMultipleType, isSelect: Bool, isCheck: Bool) {
        self.title = title
        self.type = type
        self.isSelect = isSelect
        self.isCheck = isCheck
    }
}
