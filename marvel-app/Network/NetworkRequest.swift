//
//  NetworkRequest.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 20/12/22.
//

import Foundation

protocol NetworkRequestProtocol {
    func makeRequest<Success: Decodable>(url: String?, completion: @escaping (Result<Success, NetworkError>) -> Void)
}

class NetworkRequest: NetworkRequestProtocol {
    
    func makeRequest<Success: Decodable>(url: String?, completion: @escaping (Result<Success, NetworkError>) -> Void)  {
        if let unwrappedURL = url, let url = URL(string: unwrappedURL) {
            let config: URLSessionConfiguration = .default
            let session: URLSession = URLSession(configuration: config)
            let task = session.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder: JSONDecoder = JSONDecoder()
                        let decodedData = try decoder.decode(Success.self, from: data)
                        completion(Result.success(decodedData))
                    } catch {
                        completion(Result.failure(NetworkError.decodeError))
                    }
                } else {
                    completion(Result.failure(NetworkError.invalidData))
                }
            }
            task.resume()
        } else {
            completion(Result.failure(NetworkError.invalidURL))
        }
    }
}
