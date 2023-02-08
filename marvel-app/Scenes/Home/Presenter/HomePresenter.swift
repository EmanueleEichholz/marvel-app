//
//  CharacterListPresenter.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import Foundation

protocol HomePresenterProtocol {
    func presentCharacters(with model: CharactersData?)
    func presentComics(with model: ComicsData?)
    func presentCreators(with model: CreatorsData?)
    func presentEvents(with model: EventsData?)
    func presentSeries(with model: SeriesData?)
    func presentError()
}

final class HomePresenter: HomePresenterProtocol {

    weak var view: HomeViewControllerProtocol?
    
    func presentCharacters(with model: CharactersData?) {
        if let model = model {
            var characterList: [ItemCardModel] = model.results.map { character in
                return ItemCardModel(
                        name: character.name ?? "Name Unavailable",
                        image: getImageURL(
                            path: character.thumbnail?.path,
                            pathExtension: character.thumbnail?.thumbnailExtension
                        )
                    )
            }
            
            characterList = characterList.filter {
                $0.image != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_xlarge.jpg"
            }
            
            view?.updateCharactersSection(with: characterList)
        }
    }
    
    func presentComics(with model: ComicsData?) {
        if let model = model {
            var comicsList: [ItemCardModel] = model.results.map { comic in
                return ItemCardModel(
                        name: comic.title ?? "Title Unavailable",
                        image: getImageURL(
                            path: comic.thumbnail?.path,
                            pathExtension: comic.thumbnail?.thumbnailExtension
                        )
                    )
            }
            
            comicsList = comicsList.filter {
                $0.image != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_xlarge.jpg"
            }
            
            view?.updateComicsSection(with: comicsList)
        }
    }
    
    func presentCreators(with model: CreatorsData?) {
        if let model = model {
           let creatorsList: [ItemCardModel] = model.results.map { creator in
                return ItemCardModel(
                        name: creator.fullName ?? "Name Unavailable",
                        image: getImageURL(
                            path: creator.thumbnail?.path,
                            pathExtension: creator.thumbnail?.thumbnailExtension
                        )
                    )
            }
            
            view?.updateCreatorsSection(with: creatorsList)
        }
    }
    
    func presentEvents(with model: EventsData?) {
        if let model = model {
            var eventsList: [ItemCardModel] = model.results.map { event in
                return ItemCardModel(
                        name: event.title ?? "Title Unavailable",
                        image: getImageURL(
                            path: event.thumbnail?.path,
                            pathExtension: event.thumbnail?.thumbnailExtension
                        )
                    )
            }
            
            eventsList = eventsList.filter {
                $0.image != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_xlarge.jpg"
            }
            
            view?.updateEventsSection(with: eventsList)
        }
    }
    
    func presentSeries(with model: SeriesData?) {
        if let model = model {
            var seriesList: [ItemCardModel] = model.results.map { serie in
                return ItemCardModel(
                        name: serie.title ?? "Title Unavailable",
                        image: getImageURL(
                            path: serie.thumbnail?.path,
                            pathExtension: serie.thumbnail?.thumbnailExtension
                        )
                    )
            }
            
            seriesList = seriesList.filter {
                $0.image != "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_xlarge.jpg"
            }
            
            view?.updateSeriesSection(with: seriesList)
        }
    }
    
    private func getImageURL(path: String?, pathExtension: String?) -> String {
        if let path = path, let pathExtension = pathExtension {
            return "\(path)/standard_xlarge.\(pathExtension)"
        }
        return ""
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

}
