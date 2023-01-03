//
//  HTTPMethods.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 13/12/22.
//

import Foundation

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}
