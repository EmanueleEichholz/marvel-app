//
//  CharacterListWorker.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import Foundation

typealias CharactersCompletion = (Result<Response, Error>) -> ()

protocol CharacterListWorkerProtocol {
    func getCharactersInfo(completion: @escaping CharactersCompletion)
}

final class CharacterListWorker: CharacterListWorkerProtocol {
    
    func getURL(offset: Int) -> String {
        let baseURL = "https://gateway.marvel.com"
        let path = "v1/public/characters"
        
        let ts = Int(Date().timeIntervalSince1970)
        
        let privateKey = ""
        
        let publicKey = ""
        
        let content = String(ts) + privateKey + publicKey
        
        let url = "\(baseURL)/\(path)?ts=\(ts)&apikey=\(publicKey)&hash=\(content.MD5)"
        return url
    }
    
    func getCharactersInfo(completion: @escaping CharactersCompletion) {
            if let url = URL(string: getURL(offset: 20)) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data,
                        let response = response as? HTTPURLResponse else {
                        return
                    }
                    do {
                        let result = try JSONDecoder().decode(Response.self, from: data)
                        switch response.statusCode {
                        case 200:
                            completion(Result.success(result))
                        default:
                            break
                        }
                    } catch {
                        
                    }
                }
                task.resume()
            }
        }
}
