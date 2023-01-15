//
//  FullListPresenter.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import Foundation

protocol FullListPresenterProtocol {
    func presentCharacters(with model: CharactersData?)
    func presentComics(with model: ComicsData?)
    func presentCreators(with model: CreatorsData?)
    func presentEvents(with model: EventsData?)
    func presentSeries(with model: SeriesData?)
    func presentError()
}

final class FullListPresenter {
    
    weak var view: FullListViewControllerProtocol?
    
}

extension FullListPresenter: FullListPresenterProtocol {
    
    func presentCharacters(with model: CharactersData?) {
        if let model = model {
            var characterList: [ItemCardModel] = []
            model.results.forEach { character in
                characterList.append(
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
                itemList: characterList
            )

            view?.updateView(with: fullListViewModel)

        }
    }
    
    func presentComics(with model: ComicsData?) {
        if let model = model {
            var comicsList: [ItemCardModel] = []
            model.results.forEach { comic in
                comicsList.append(
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
                itemList: comicsList
            )
            
            view?.updateView(with: fullListViewModel)
        }
    }
    
    func presentCreators(with model: CreatorsData?) {
        if let model = model {
            var creatorsList: [ItemCardModel] = []
            model.results.forEach { creator in
                creatorsList.append(
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
                itemList: creatorsList
            )
            
            view?.updateView(with: fullListViewModel)
        }
    }
    
    func presentEvents(with model: EventsData?) {
        if let model = model {
            var eventsList: [ItemCardModel] = []
            model.results.forEach { event in
                eventsList.append(
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
                itemList: eventsList
            )
            
            view?.updateView(with: fullListViewModel)
        }
    }
    
    func presentSeries(with model: SeriesData?) {
        if let model = model {
            var seriesList: [ItemCardModel] = []
            model.results.forEach { serie in
                seriesList.append(
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
                itemList: seriesList
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
    
}
