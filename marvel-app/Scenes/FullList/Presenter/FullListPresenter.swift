//
//  FullListPresenter.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import Foundation

protocol FullListPresenterProtocol {
    func presentCharacters(model: [CharacterResponseModel]?, total: Int?)
    func presentComics(model: [ComicsResponseModel]?, total: Int?)
    func presentCreators(model: [CreatorsResponseModel]?, total: Int?)
    func presentEvents(model: [EventsResponseModel]?, total: Int?)
    func presentSeries(model: [SeriesResponseModel]?, total: Int?)
    func presentError()
}

final class FullListPresenter {
    
    weak var view: FullListViewControllerProtocol?
    
}

extension FullListPresenter: FullListPresenterProtocol {
    
    func presentCharacters(model: [CharacterResponseModel]?, total: Int?) {
        if let model = model {
            var list: [ItemCardModel] = []
            model.forEach { character in
                list.append(
                    ItemCardModel(
                        name: character.name ?? "Name Unavailable",
                        image: getImageURL(
                            path: character.thumbnail?.path,
                            pathExtension: character.thumbnail?.thumbnailExtension
                        )
                    )
                )
            }
             
            let fullListViewModel = FullListViewModel(
                title: "CHARACTERS",
                searchBarPlaceholder: "Search characters by name",
                itemList: list,
                numberOfCells: getNumberOfCells(
                    totalLoaded: list.count,
                    totalAvailable: total
                )
            )
            
            updateView(with: fullListViewModel)
        }
    }
    
    func presentComics(model: [ComicsResponseModel]?, total: Int?) {
        if let model = model {
            var list: [ItemCardModel] = []
            model.forEach { comic in
                list.append(
                    ItemCardModel(
                        name: comic.title ?? "Title Unavailable",
                        image: getImageURL(
                            path: comic.thumbnail?.path,
                            pathExtension: comic.thumbnail?.thumbnailExtension
                        )
                    )
                )
            }
            
            let fullListViewModel = FullListViewModel(
                title: "COMICS",
                searchBarPlaceholder: "Search comics by title",
                itemList: list,
                numberOfCells: getNumberOfCells(
                    totalLoaded: list.count,
                    totalAvailable: total
                )
            )
            
            updateView(with: fullListViewModel)
        }
    }
    
    func presentCreators(model: [CreatorsResponseModel]?, total: Int?) {
        if let model = model {
            var list: [ItemCardModel] = []
            model.forEach { creator in
                list.append(
                    ItemCardModel(
                        name: creator.fullName ?? "Name Unavailable",
                        image: getImageURL(
                            path: creator.thumbnail?.path,
                            pathExtension: creator.thumbnail?.thumbnailExtension
                        )
                    )
                )
            }
            
            let fullListViewModel = FullListViewModel(
                title: "CREATORS",
                searchBarPlaceholder: "Search creators by name",
                itemList: list,
                numberOfCells: getNumberOfCells(
                    totalLoaded: list.count,
                    totalAvailable: total
                )
            )
            
            updateView(with: fullListViewModel)
        }
    }
    
    func presentEvents(model: [EventsResponseModel]?, total: Int?) {
        if let model = model {
            var list: [ItemCardModel] = []
            model.forEach { event in
                list.append(
                    ItemCardModel(
                        name: event.title ?? "Title Unavailable",
                        image: getImageURL(
                            path: event.thumbnail?.path,
                            pathExtension: event.thumbnail?.thumbnailExtension
                        )
                    )
                )
            }
            
            let fullListViewModel = FullListViewModel(
                title: "EVENTS",
                searchBarPlaceholder: "Search events by name",
                itemList: list,
                numberOfCells: getNumberOfCells(
                    totalLoaded: list.count,
                    totalAvailable: total
                )
            )
            
            updateView(with: fullListViewModel)
        }
    }
    
    func presentSeries(model: [SeriesResponseModel]?, total: Int?) {
        if let model = model {
            var list: [ItemCardModel] = []
            model.forEach { serie in
                list.append(
                    ItemCardModel(
                        name: serie.title ?? "Title Unavailable",
                        image: getImageURL(
                            path: serie.thumbnail?.path,
                            pathExtension: serie.thumbnail?.thumbnailExtension
                        )
                    )
                )
            }
            
            let fullListViewModel = FullListViewModel(
                title: "SERIES",
                searchBarPlaceholder: "Search series by title",
                itemList: list,
                numberOfCells: getNumberOfCells(
                    totalLoaded: list.count,
                    totalAvailable: total
                )
            )
            
            updateView(with: fullListViewModel)
        }
    }
    
    private func updateView(with viewModel: FullListViewModel) {
        if viewModel.itemList.isEmpty {
            presentEmptyState()
        } else {
            view?.updateView(with: viewModel)
        }
    }
    
    private func presentEmptyState() {
        let alertModel = AlertModel(
            title: "No results for this search",
            message: "Try again or try a different search",
            firstButtonTitle: "Try again",
            secondButtonTitle: "Back"
        )

        view?.updateAlert(with: alertModel)
    }
    
    func presentError() {
        let alertModel = AlertModel(
            title: "An error occurred and the data could not be retrieved",
            message: "Try again or come back later",
            firstButtonTitle: "Try again",
            secondButtonTitle: "Back"
        )

        view?.updateAlert(with: alertModel)
    }
    
    private func getImageURL(path: String?, pathExtension: String?) -> String {
        if let path = path, let pathExtension = pathExtension {
            return "\(path)/standard_xlarge.\(pathExtension)"
        }
        return ""
    }
    
    private func getNumberOfCells(totalLoaded: Int, totalAvailable: Int?) -> Int {
        
        guard let totalAvailable = totalAvailable else {
            return totalLoaded
        }
        
        if totalLoaded == 0 && totalAvailable > 0 {
            return 9
        }
        
        if totalLoaded < totalAvailable {
            return totalLoaded + 3
        }
        
        return totalLoaded
        
    }
    
}
