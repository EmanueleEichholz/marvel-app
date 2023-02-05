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
    
    private var updatedOffset: Int = 0
    private var isRequesting: Bool = false
    private var charactersList: [CharacterResponseModel] = []
    private var comicsList: ComicsData?
    private var creatorsList: CreatorsData?
    private var eventsList: EventsData?
    private var seriesList: SeriesData?
    
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
        if !isRequesting {
            isRequesting = true
            switch listType {
            case .characters:
                getCharacters(nameStartsWith: nameStartsWith)
            case .comics:
                getComics(nameStartsWith: nameStartsWith)
            case .creators:
                getCreators(nameStartsWith: nameStartsWith)
            case .events:
                getEvents(nameStartsWith: nameStartsWith)
            case .series:
                getSeries(nameStartsWith: nameStartsWith)
            }
        }
    }
    
    private func getCharacters(nameStartsWith: String?) {
        worker.fetchCharacters(namesStartsWith: nameStartsWith, offset: updatedOffset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.charactersList.append(contentsOf: response.data?.results ?? [])
                self?.presenter.presentCharacters(with: self?.charactersList)
                self?.updatedOffset += 20
                self?.isRequesting = false
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func getComics(nameStartsWith: String?) {
        worker.fetchComics(namesStartsWith: nameStartsWith, offset: updatedOffset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.presentComics(with: response.data)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func getCreators(nameStartsWith: String?) {
        worker.fetchCreators(namesStartsWith: nameStartsWith, offset: updatedOffset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.presentCreators(with: response.data)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func getEvents(nameStartsWith: String?) {
        worker.fetchEvents(namesStartsWith: nameStartsWith, offset: updatedOffset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.presenter.presentEvents(with: response.data)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func getSeries(nameStartsWith: String?) {
        worker.fetchSeries(namesStartsWith: nameStartsWith, offset: updatedOffset) { [weak self] result in
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
