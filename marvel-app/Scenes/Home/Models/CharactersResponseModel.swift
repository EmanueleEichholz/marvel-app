//
//  CharacterListResponseModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 06/11/22.
//

import Foundation

struct CharactersResult: Decodable {
    let code: Int?
    let status: String?
    let data: CharactersData?
}

struct CharactersData: Decodable {
    let results: [CharacterResponseModel]
}

struct CharacterResponseModel: Decodable, GenericResponseModel {
    let name: String?
    let description: String?
    let resourceURI: String?
    let thumbnail: ImageResponseModel?
    let comics: ListResponseModel?
    let series: ListResponseModel?
    let events: ListResponseModel?
}
