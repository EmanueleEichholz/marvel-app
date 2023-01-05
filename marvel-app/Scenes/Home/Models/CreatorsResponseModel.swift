//
//  CreatorsResponseModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 03/01/23.
//

import Foundation

struct CreatorsResult: Codable {
    let code: Int?
    let status: String?
    let data: CreatorsData?
}

struct CreatorsData: Codable {
    let results: [CreatorsResponseModel]
}

struct CreatorsResponseModel: Codable, GenericResponseModel {
    let fullName: String?
    let id: Int?
    let thumbnail: ImageResponseModel?
}
