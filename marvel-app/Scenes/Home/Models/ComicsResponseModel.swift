//
//  ComicsResponseModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 03/01/23.
//

import Foundation

struct ComicsResult: Codable {
    let code: Int?
    let status: String?
    let data: ComicsData?
}

struct ComicsData: Codable {
    let results: [ComicsResponseModel]
}

struct ComicsResponseModel: Codable {
    let title: String?
    let id: Int?
    let description: String?
    let thumbnail: ImageResponseModel?
}

