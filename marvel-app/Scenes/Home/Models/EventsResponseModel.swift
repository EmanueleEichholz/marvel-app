//
//  EventsResponseModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 03/01/23.
//

import Foundation

struct EventsResult: Codable {
    let code: Int?
    let status: String?
    let data: EventsData?
}

struct EventsData: Codable {
    let results: [EventsResponseModel]
}

struct EventsResponseModel: Codable, GenericResponseModel {
    let title: String?
    let id: Int?
    let description: String?
    let thumbnail: ImageResponseModel?
}
