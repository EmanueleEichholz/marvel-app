//
//  FullListInteractor.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import Foundation

protocol FullListInteractorProtocol {
    func viewDidLoad()
    func scrolledForMoreItems(searchBarContent: String?)
    func searchButtonClicked(searchBarContent: String?)
    func backButtonTapped()
}

final class FullListInteractor {
    
    private let coordinator: FullListCoordinatorProtocol
    private let presenter: FullListPresenterProtocol
    private let worker: FullListWorkerProtocol
    private let listType: ListTypeEnum
    
    private var updatedOffset: Int = 0
    private var isRequesting: Bool = false
    private var charactersList: [CharacterResponseModel] = []
    private var comicsList: [ComicsResponseModel] = []
    private var creatorsList: [CreatorsResponseModel] = []
    private var eventsList: [EventsResponseModel] = []
    private var seriesList: [SeriesResponseModel] = []
    
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
    
    func viewDidLoad() {
        fetchData(nameStartsWith: nil)
    }
    
    func scrolledForMoreItems(searchBarContent: String?) {
        fetchData(nameStartsWith: searchBarContent)
    }
    
    func searchButtonClicked(searchBarContent: String?) {
        cleanVariables()
        fetchData(nameStartsWith: searchBarContent)
    }

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
                self?.presenter.presentCharacters(model: self?.charactersList, total: response.data?.total)
                self?.updatedOffset += 20
                self?.isRequesting = false
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func getComics(nameStartsWith: String?) { // FIXME: titleStartsWith
        worker.fetchComics(namesStartsWith: nameStartsWith, offset: updatedOffset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.comicsList.append(contentsOf: response.data?.results ?? [])
                self?.presenter.presentComics(model: self?.comicsList, total: response.data?.total)
                self?.updatedOffset += 20
                self?.isRequesting = false
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func getCreators(nameStartsWith: String?) {
        worker.fetchCreators(namesStartsWith: nameStartsWith, offset: updatedOffset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.creatorsList.append(contentsOf: response.data?.results ?? [])
                self?.presenter.presentCreators(model: self?.creatorsList, total: response.data?.total)
                self?.updatedOffset += 20
                self?.isRequesting = false
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func getEvents(nameStartsWith: String?) {
        worker.fetchEvents(namesStartsWith: nameStartsWith, offset: updatedOffset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.eventsList.append(contentsOf: response.data?.results ?? [])
                self?.presenter.presentEvents(model: self?.eventsList, total: response.data?.total)
                self?.updatedOffset += 20
                self?.isRequesting = false
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func getSeries(nameStartsWith: String?) { //FIXME: titleStartsWith
        worker.fetchSeries(namesStartsWith: nameStartsWith, offset: updatedOffset) { [weak self] result in
            switch result {
            case .success(let response):
                self?.seriesList.append(contentsOf: response.data?.results ?? [])
                self?.presenter.presentSeries(model: self?.seriesList, total: response.data?.total)
                self?.updatedOffset += 20
                self?.isRequesting = false
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    private func cleanVariables() {
        updatedOffset = 0
        charactersList = []
        comicsList = []
        creatorsList = []
        eventsList = []
        seriesList = []
    }
    
    func backButtonTapped() {
        coordinator.didTapBackButton()
    }
    
}
