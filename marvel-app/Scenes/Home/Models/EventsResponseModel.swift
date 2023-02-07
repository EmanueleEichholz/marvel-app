//
//  EventsResponseModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 03/01/23.
//

import Foundation

struct EventsResult: Decodable {
    let code: Int?
    let status: String?
    let data: EventsData?
}

struct EventsData: Decodable {
    let results: [EventsResponseModel]
    let total: Int?
}

struct EventsResponseModel: Decodable, GenericResponseModel {
    let title: String?
    let description: String?
    let thumbnail: ImageResponseModel?
    let urls: [URLResponseModel]?
    let comics: ListResponseModel?
    let series: ListResponseModel?
    let characters: ListResponseModel?
    let creators: ListResponseModel?
}
