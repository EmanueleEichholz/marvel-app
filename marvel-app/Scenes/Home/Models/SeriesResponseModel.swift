//
//  SeriesResponseModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 03/01/23.
//

import Foundation

struct SeriesResult: Decodable {
    let code: Int?
    let status: String?
    let data: SeriesData?
}

struct SeriesData: Decodable {
    let results: [SeriesResponseModel]
}

struct SeriesResponseModel: Decodable,GenericResponseModel {
    let title: String?
    let description: String?
    let thumbnail: ImageResponseModel?
    let urls: [URLResponseModel]?
    let comics: ListResponseModel?
    let events: ListResponseModel?
    let characters: ListResponseModel?
    let creators: ListResponseModel?
}
