//
//  CharacterListResponseModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 06/11/22.
//

import Foundation

struct CharactersResult: Codable {
    let code: Int?
    let status: String?
    let data: CharacterListResponseModel?
}

struct CharacterListResponseModel: Codable {
    let results: [CharacterResponseModel]
}

struct CharacterResponseModel: Codable {
    let name: String?
    let id: Int?
    let description: String?
    let thumbnail: Image?
}

struct Image: Codable {
    let path: String?
    let thumbnailExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
