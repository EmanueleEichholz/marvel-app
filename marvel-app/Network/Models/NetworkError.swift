//
//  NetworkError.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 16/11/22.
//

import Foundation

enum NetworkError: Error {
    case notFound
    case decodeError
    case invalidData
    case invalidURL
    case invalidStatusCode
    case networkError
    case serverError
}

extension NetworkError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Not found"
        case .decodeError:
            return "Error during data decoding"
        case .invalidData:
            return "Data error"
        case .invalidURL:
            return "Invalid URL"
        case .invalidStatusCode:
            return "Invalid status code"
        case .networkError:
            return "An error has occurred. Please verify your connection."
        case .serverError:
            return "Server error"
        }
    }
}
