//
//  ComicsResponseModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 03/01/23.
//

import Foundation

struct ComicsResult: Decodable {
    let code: Int?
    let status: String?
    let data: ComicsData?
}

struct ComicsData: Decodable {
    let results: [ComicsResponseModel]
}

struct ComicsResponseModel: Decodable, GenericResponseModel {
    let title: String?
    let description: String?
    let resourceURI: String?
    let thumbnail: ImageResponseModel?
    let creators: ListResponseModel?
    let characters: ListResponseModel?
    let events: ListResponseModel?
}

