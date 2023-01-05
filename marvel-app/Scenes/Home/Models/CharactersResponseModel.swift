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
    let data: CharactersData?
}

struct CharactersData: Codable {
    let results: [CharacterResponseModel]
}

struct CharacterResponseModel: Codable, GenericResponseModel {
    let name: String?
    let id: Int?
    let description: String?
    let thumbnail: ImageResponseModel?
}
