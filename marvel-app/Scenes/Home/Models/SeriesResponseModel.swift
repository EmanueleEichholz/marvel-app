//
//  SeriesResponseModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 03/01/23.
//

import Foundation

struct SeriesResult: Codable {
    let code: Int?
    let status: String?
    let data: SeriesData?
}

struct SeriesData: Codable {
    let results: [SeriesResponseModel]
}

struct SeriesResponseModel: Codable,GenericResponseModel {
    let title: String?
    let id: Int?
    let description: String?
    let thumbnail: ImageResponseModel?
}
