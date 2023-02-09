//
//  CharacterListWorker.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import Foundation

typealias CharactersCompletion = (Result<CharactersResult, NetworkError>) -> ()
typealias ComicsCompletion = (Result<ComicsResult, NetworkError>) -> ()
typealias CreatorsCompletion = (Result<CreatorsResult, NetworkError>) -> ()
typealias EventsCompletion = (Result<EventsResult, NetworkError>) -> ()
typealias SeriesCompletion = (Result<SeriesResult, NetworkError>) -> ()

protocol HomeWorkerProtocol {
    func fetchCharacters(completion: @escaping CharactersCompletion)
    func fetchComics(completion: @escaping ComicsCompletion)
    func fetchCreators(completion: @escaping CreatorsCompletion)
    func fetchEvents(completion: @escaping EventsCompletion)
    func fetchSeries(completion: @escaping SeriesCompletion)
}

final class HomeWorker {
    
    let provider: NetworkRequestProtocol
    
    init(with provider: NetworkRequestProtocol) {
        self.provider = provider
    }
    
}

extension HomeWorker: HomeWorkerProtocol {

    func fetchCharacters(completion: @escaping CharactersCompletion) {
        let url = MarvelURLBuilder(with: .characters)
            .withLimit(10)
            .buildURL()
        provider.makeRequest(url: url) { (response: Result<CharactersResult, NetworkError>) in
            completion(response)
        }
    }
    
    func fetchComics(completion: @escaping ComicsCompletion) {
        let url = MarvelURLBuilder(with: .comics)
            .withLimit(10)
            .buildURL()
        provider.makeRequest(url: url) { (response: Result<ComicsResult, NetworkError>) in
            completion(response)
        }
    }
    
    func fetchCreators(completion: @escaping CreatorsCompletion) {
        let url = MarvelURLBuilder(with: .creators)
            .withLimit(5)
            .buildURL()
        provider.makeRequest(url: url) { (response: Result<CreatorsResult, NetworkError>) in
            completion(response)
        }
    }
    
    func fetchEvents(completion: @escaping EventsCompletion) {
        let url = MarvelURLBuilder(with: .events)
            .withLimit(10)
            .buildURL()
        provider.makeRequest(url: url) { (response: Result<EventsResult, NetworkError>) in
            completion(response)
        }
    }
    
    func fetchSeries(completion: @escaping SeriesCompletion) {
        let url = MarvelURLBuilder(with: .series)
            .withLimit(10)
            .buildURL()
        provider.makeRequest(url: url) { (response: Result<SeriesResult, NetworkError>) in
            completion(response)
        }
    }

}
