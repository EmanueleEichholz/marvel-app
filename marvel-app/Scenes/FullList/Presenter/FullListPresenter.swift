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
                searchBarPlaceholder: "SEARCH CHARACTERS BY NAME",
                itemList: list,
                numberOfCells: getNumberOfCells(
                    totalLoaded: list.count,
                    totalAvailable: total
                )
            )

            view?.updateView(with: fullListViewModel)

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
                searchBarPlaceholder: "SEARCH COMICS BY NAME",
                itemList: list,
                numberOfCells: getNumberOfCells(
                    totalLoaded: list.count,
                    totalAvailable: total
                )
            )
            
            view?.updateView(with: fullListViewModel)
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
                searchBarPlaceholder: "SEARCH CREATORS BY NAME",
                itemList: list,
                numberOfCells: getNumberOfCells(
                    totalLoaded: list.count,
                    totalAvailable: total
                )
            )
            
            view?.updateView(with: fullListViewModel)
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
                searchBarPlaceholder: "SEARCH EVENTS BY NAME",
                itemList: list,
                numberOfCells: getNumberOfCells(
                    totalLoaded: list.count,
                    totalAvailable: total
                )
            )
            
            view?.updateView(with: fullListViewModel)
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
                searchBarPlaceholder: "SEARCH SERIES BY NAME",
                itemList: list,
                numberOfCells: getNumberOfCells(
                    totalLoaded: list.count,
                    totalAvailable: total
                )
            )
            
            view?.updateView(with: fullListViewModel)
        }
    }
    
    func presentError() {
        let alertModel = AlertModel(
            title: "Ocorreu um erro e não foi possível trazer os dados.",
            message: "Tente novamente ou retorne mais tarde.",
            firstButtonTitle: "Tentar novamente",
            secondButtonTitle: "Cancelar"
        )

        view?.updateView(with: alertModel)
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
