//
//  FullListWorker.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import Foundation

protocol FullListWorkerProtocol {
    func fetchCharacters(namesStartsWith: String?, offset: Int?, completion: @escaping CharactersCompletion)
    func fetchComics(titleStartsWith: String?, offset: Int?, completion: @escaping ComicsCompletion)
    func fetchCreators(namesStartsWith: String?, offset: Int?, completion: @escaping CreatorsCompletion)
    func fetchEvents(namesStartsWith: String?, offset: Int?, completion: @escaping EventsCompletion)
    func fetchSeries(titleStartsWith: String?, offset: Int?, completion: @escaping SeriesCompletion)
}

final class FullListWorker {
    
    let provider: NetworkRequestProtocol
    
    init(with provider: NetworkRequestProtocol) {
        self.provider = provider
    }
    
}

extension FullListWorker: FullListWorkerProtocol {
    
    func fetchCharacters(namesStartsWith: String?, offset: Int?, completion: @escaping CharactersCompletion) {
        let url = MarvelURLBuilder(with: .characters)
            .withFilterByName(namesStartsWith)
            .withOffset(offset)
            .buildURL()
        provider.makeRequest(url: url) { (response: Result<CharactersResult, NetworkError>) in
            completion(response)
        }
    }
    
    func fetchComics(titleStartsWith: String?, offset: Int?, completion: @escaping ComicsCompletion) {
        let url = MarvelURLBuilder(with: .comics)
            .withFilterByTitle(titleStartsWith)
            .withOffset(offset)
            .buildURL()
        provider.makeRequest(url: url) { (response: Result<ComicsResult, NetworkError>) in
            completion(response)
        }
    }
    
    func fetchCreators(namesStartsWith: String?, offset: Int?, completion: @escaping CreatorsCompletion) {
        let url = MarvelURLBuilder(with: .creators)
            .withFilterByName(namesStartsWith)
            .withOffset(offset)
            .buildURL()
        provider.makeRequest(url: url) { (response: Result<CreatorsResult, NetworkError>) in
            completion(response)
        }
    }
    
    func fetchEvents(namesStartsWith: String?, offset: Int?, completion: @escaping EventsCompletion) {
        let url = MarvelURLBuilder(with: .events)
            .withFilterByName(namesStartsWith)
            .withOffset(offset)
            .buildURL()
        provider.makeRequest(url: url) { (response: Result<EventsResult, NetworkError>) in
            completion(response)
        }
    }
    
    func fetchSeries(titleStartsWith: String?, offset: Int?, completion: @escaping SeriesCompletion) {
        let url = MarvelURLBuilder(with: .series)
            .withFilterByTitle(titleStartsWith)
            .withOffset(offset)
            .buildURL()
        provider.makeRequest(url: url) { (response: Result<SeriesResult, NetworkError>) in
            completion(response)
        }
    }
    
    
}
