//
//  NetworkRequest.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 16/11/22.
//

import Foundation

protocol NetworkRequest {
    var baseURL: String { get }
    var pathURL: String { get }
    var method: HTTPMethod { get }
}

enum HTTPMethod: String {
    case get
}

extension NetworkRequest {
    var baseURL: String {
        "https://gateway.marvel.com"
    }
}
