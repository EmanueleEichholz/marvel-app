//
//  CreatorsResponseModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 03/01/23.
//

import Foundation

struct CreatorsResult: Decodable {
    let code: Int?
    let status: String?
    let data: CreatorsData?
}

struct CreatorsData: Decodable {
    let results: [CreatorsResponseModel]
    let total: Int?
}

struct CreatorsResponseModel: Decodable, GenericResponseModel {
    let fullName: String?
    let thumbnail: ImageResponseModel?
    let urls: [URLResponseModel]?
    let comics: ListResponseModel?
    let series: ListResponseModel?
    let events: ListResponseModel?
}
