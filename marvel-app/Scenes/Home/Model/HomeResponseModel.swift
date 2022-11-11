//
//  CharacterListResponseModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 06/11/22.
//

import Foundation

struct Response: Codable {
    let code: Int?
    let status: String?
    let data: ResponseData?
}

struct ResponseData: Codable {
    let results: [Character]
}

struct Character: Codable {
    let name: String?
    let id: Int?
    let description: String?
//    let thumbnail: Thumbnail?
}

//struct Thumbnail: Codable {
//    let thumbnailExtension: String
//    
//    enum CodingKeys: String, CodingKey {
//        case thumbnailExtension = "extension"
//    }
//}
