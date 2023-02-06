//
//  PersonData.swift
//  iOS-Codable-Demo
//
//  Created by 王潇 on 2023/1/30.
//

import Foundation
import UIKit

struct Person: Codable {
    var name: String
    var favoriteColor: String
    private enum CodingKeys: String, CodingKey {
        case name, favoriteColor
    }
    
    init(name: String, favoriteColor: String) {
        self.name = name
        self.favoriteColor = favoriteColor
    }
    
    init(form decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.favoriteColor = try container.decode(String.self, forKey: .favoriteColor)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(favoriteColor, forKey: .favoriteColor)
    }
}

struct Pet: Codable {
    var code: Int
    var data: PetData
    
    init(code: Int, data: PetData) {
        self.code = code
        self.data = data
    }

    private enum CodingKeys: String, CodingKey {
        case code, data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(Int.self, forKey: .code)
        self.data = try container.decode(PetData.self, forKey: .data)
    }
}

struct PetData: Codable {
    var id: Int
    var name: String
    var photoUrls: [String]
    var category: PetCategory
    var tags: [PetTags]
    var status: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, photoUrls, category, tags, status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoUrls = try container.decode([String].self, forKey: .photoUrls)
        self.category = try container.decode(PetCategory.self, forKey: .category)
        self.tags = try container.decode([PetTags].self, forKey: .tags)
        self.status = try container.decode(String.self, forKey: .status)
    }

    init(id: Int, name: String, photoUrls: [String], category: PetCategory, tags: [PetTags], status: String) {
        self.id = id
        self.name = name
        self.photoUrls = photoUrls
        self.category = category
        self.tags = tags
        self.status = status
    }
}

struct PetCategory: Codable {
    var id: Int
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

struct PetTags: Codable {
    var id: Int
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
