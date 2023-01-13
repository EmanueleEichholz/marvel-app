//
//  CharacterListInteractor.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import Foundation

protocol HomeInteractorProtocol {
    func viewDidLoad()
    func didSelectCharacter(at index: Int)
    func didSelectComic(at index: Int)
    func didSelectCreator(at index: Int)
    func didSelectEvent(at index: Int)
    func didSelectSerie(at index: Int)
}

final class HomeInteractor {

    private let coordinator: HomeCoordinatorProtocol
    private let presenter: HomePresenterProtocol
    private let worker: HomeWorkerProtocol
    
    private var charactersList: CharactersData?
    private var comicsList: ComicsData?
    private var creatorsList: CreatorsData?
    private var eventsList: EventsData?
    private var seriesList: SeriesData?
    
    init(
        coordinator: HomeCoordinatorProtocol,
         presenter: HomePresenterProtocol,
         worker: HomeWorkerProtocol
    ) {
        self.coordinator = coordinator
        self.presenter = presenter
        self.worker = worker
    }
    
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func viewDidLoad() {
        getCharacters()
        getComics()
        getCreators()
        getEvents()
        getEvents()
        getSeries()
    }
    
    private func getCharacters() {
        worker.fetchCharacters(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.charactersList = response.data
                self?.presenter.presentCharacters(with: self?.charactersList)
            case .failure:
                self?.presenter.presentError()
            }
        })
    }
    
    private func getComics() {
        worker.fetchComics(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.comicsList = response.data
                self?.presenter.presentComics(with: self?.comicsList)
            case .failure:
                self?.presenter.presentError()
            }
        })
    }
    
    private func getCreators() {
        worker.fetchCreators(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.creatorsList = response.data
                self?.presenter.presentCreators(with: self?.creatorsList)
            case .failure:
                self?.presenter.presentError()
            }
        })
    }
    
    private func getEvents() {
        worker.fetchEvents(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.eventsList = response.data
                self?.presenter.presentEvents(with: self?.eventsList)
            case .failure:
                self?.presenter.presentError()
            }
        })
    }
    
    private func getSeries() {
        worker.fetchSeries(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.seriesList = response.data
                self?.presenter.presentSeries(with: self?.seriesList)
            case .failure:
                self?.presenter.presentError()
            }
        })
    }
    
    
    func didSelectCharacter(at index: Int) {
        if let unwrappedCharactersList = charactersList?.results {
            if unwrappedCharactersList.indices.contains(index) {
                coordinator.goToDetailsScreen(detailsInfo: unwrappedCharactersList[index])
            } else {
                coordinator.didTapSeeAll(listType: .characters)
            }
        }
    }
    
    func didSelectComic(at index: Int) {
        if let unwrappedComicsList = comicsList?.results {
            if unwrappedComicsList.indices.contains(index) {
                coordinator.goToDetailsScreen(detailsInfo: unwrappedComicsList[index])
            } else {
                coordinator.didTapSeeAll(listType: .comics)
            }
        }
    }
    
    func didSelectCreator(at index: Int) {
        if let unwrappedCreatorList = creatorsList?.results {
            if unwrappedCreatorList.indices.contains(index) {
                coordinator.goToDetailsScreen(detailsInfo: unwrappedCreatorList[index])
            } else {
                coordinator.didTapSeeAll(listType: .creators)
            }
        }
    }
    
    func didSelectEvent(at index: Int) {
        if let unwrappedEventList = eventsList?.results {
            if unwrappedEventList.indices.contains(index) {
                coordinator.goToDetailsScreen(detailsInfo: unwrappedEventList[index])
            } else {
                coordinator.didTapSeeAll(listType: .events)
            }
        }
    }
    
    func didSelectSerie(at index: Int) {
        if let unwrappedSeriesList = seriesList?.results {
            if unwrappedSeriesList.indices.contains(index) {
                coordinator.goToDetailsScreen(detailsInfo: unwrappedSeriesList[index])
            } else {
                coordinator.didTapSeeAll(listType: .series)
            }
        }
    }
    
}
