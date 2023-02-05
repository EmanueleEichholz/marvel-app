//
//  FullListInteractor.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import Foundation

protocol FullListInteractorProtocol {
    func fetchData(nameStartsWith: String?)
    func didTapBackButton()
}

final class FullListInteractor {
    
    private let coordinator: FullListCoordinatorProtocol
    private let presenter: FullListPresenterProtocol
    private let worker: FullListWorkerProtocol
    private let listType: ListTypeEnum
    
    init(
        coordinator: FullListCoordinatorProtocol,
        presenter: FullListPresenterProtocol,
        worker: FullListWorkerProtocol,
        listType: ListTypeEnum
    ) {
        self.coordinator = coordinator
        self.presenter = presenter
        self.worker = worker
        self.listType = listType
    }
    
}

extension FullListInteractor: FullListInteractorProtocol {
    
    func fetchData(nameStartsWith: String?) {
        let offset = 0
        
        switch listType {
        case .characters:
            getCharacters(nameStartsWith: nameStartsWith, offset: offset)
        case .comics:
            getComics(nameStartsWith: nameStartsWith, offset: offset)
        case .creators:
            getCreators(nameStartsWith: nameStartsWith, offset: offset)
        case .events:
            getEvents(nameStartsWith: nameStartsWith, offset: offset)
        case .series:
            getSeries(nameStartsWith: nameStartsWith, offset: offset)
        }
    }
    
    private func getCharacters(nameStartsWith: String?, offset: Int?) {
        worker.fetchCharacters(namesStartsWith: nameStartsWith, offset: offset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.presentCharacters(with: response.data)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func getComics(nameStartsWith: String?, offset: Int?) {
        worker.fetchComics(namesStartsWith: nameStartsWith, offset: offset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.presentComics(with: response.data)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func getCreators(nameStartsWith: String?, offset: Int?) {
        worker.fetchCreators(namesStartsWith: nameStartsWith, offset: offset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.presentCreators(with: response.data)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func getEvents(nameStartsWith: String?, offset: Int?) {
        worker.fetchEvents(namesStartsWith: nameStartsWith, offset: offset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.presentEvents(with: response.data)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func getSeries(nameStartsWith: String?, offset: Int?) {
        worker.fetchSeries(namesStartsWith: nameStartsWith, offset: offset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.presentSeries(with: response.data)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    func didTapBackButton() {
        coordinator.didTapBackButton()
    }
    
}
