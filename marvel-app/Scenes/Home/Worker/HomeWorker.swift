//
//  CharacterListWorker.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import Foundation

typealias CharactersCompletion = (Result<CharactersResult, NetworkError>) -> ()

protocol HomeWorkerProtocol {
    func fetchCharacters(completion: @escaping CharactersCompletion)
//    func fetchComics(completion: @escaping CharactersCompletion)
//    func fetchCreators(completion: @escaping CharactersCompletion)
//    func fetchEvents(completion: @escaping CharactersCompletion)
//    func fetchSeries(completion: @escaping CharactersCompletion)
//    func fetchStories(completion: @escaping CharactersCompletion)
}

final class HomeWorker: HomeWorkerProtocol {
    
    let provider: NetworkRequestProtocol
    
    init(with provider: NetworkRequestProtocol) {
        self.provider = provider
    }
    
    func fetchCharacters(completion: @escaping CharactersCompletion) {
        let url = MarvelURLBuilder(with: .characters)
            .buildURL()
        
        provider.makeRequest(url: url) { (response: Result<CharactersResult, NetworkError>) in
            completion(response)
        }
    }
}
