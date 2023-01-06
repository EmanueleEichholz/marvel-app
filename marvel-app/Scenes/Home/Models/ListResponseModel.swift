//
//  ListResponseModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 05/01/23.
//

import Foundation

struct ListResponseModel: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    let name: String
}
