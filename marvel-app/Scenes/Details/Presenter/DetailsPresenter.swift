//
//  DetailsPresenter.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 04/01/23.
//

import Foundation

protocol DetailsPresenterProtocol {
    func presentDetails(detailsModel: GenericResponseModel)
}

final class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewControllerProtocol?
    
    func presentDetails(detailsModel: GenericResponseModel) {
        if let charactersModel = detailsModel as? CharacterResponseModel {
            view?.updateDetailsView(with: getCharactersDetailsViewModel(with: charactersModel))
            return
        }
        
        if let comicsModel = detailsModel as? ComicsResponseModel {
            view?.updateDetailsView(with: getComicsDetailsViewModel(with: comicsModel))
            return
        }
        
        if let creatorsModel = detailsModel as? CreatorsResponseModel {
            view?.updateDetailsView(with: getCreatorsDetailsViewModel(with: creatorsModel))
            return
        }
        
        if let eventsModel = detailsModel as? EventsResponseModel {
            view?.updateDetailsView(with: getEventsDetailsViewModel(with: eventsModel))
            return
        }
        
        if let seriesModel = detailsModel as? SeriesResponseModel {
            view?.updateDetailsView(with: getSeriesDetailsViewModel(with: seriesModel))
            return
        }
        
    }
    
    private func getCharactersDetailsViewModel(with characterResponseModel: CharacterResponseModel) -> DetailsViewModel {
        return DetailsViewModel(
            image: getImageURL(
                path: characterResponseModel.thumbnail?.path,
                pathExtension: characterResponseModel.thumbnail?.thumbnailExtension
            ),
            name: characterResponseModel.name,
            description: characterResponseModel.description,
            lists: getLists(
                characters: nil,
                comics: characterResponseModel.comics,
                creators: nil,
                events: characterResponseModel.events,
                series: characterResponseModel.series,
                sites: characterResponseModel.urls
            )
        )
    }
    
    private func getComicsDetailsViewModel(with comicsResponseModel: ComicsResponseModel) -> DetailsViewModel {
        return DetailsViewModel(
            image: getImageURL(
                path: comicsResponseModel.thumbnail?.path,
                pathExtension: comicsResponseModel.thumbnail?.thumbnailExtension
            ),
            name: comicsResponseModel.title,
            description: comicsResponseModel.description,
            lists: getLists(
                characters: comicsResponseModel.characters,
                comics: nil,
                creators: comicsResponseModel.creators,
                events: comicsResponseModel.events,
                series: nil,
                sites: comicsResponseModel.urls
            )
        )
    }
    
    private func getCreatorsDetailsViewModel(with creatorsResponseModel: CreatorsResponseModel) -> DetailsViewModel {
        return DetailsViewModel(
            image: getImageURL(
                path: creatorsResponseModel.thumbnail?.path,
                pathExtension: creatorsResponseModel.thumbnail?.thumbnailExtension
            ),
            name: creatorsResponseModel.fullName,
            description: nil,
            lists: getLists(
                characters: nil,
                comics: creatorsResponseModel.comics,
                creators: nil,
                events: creatorsResponseModel.events,
                series: creatorsResponseModel.series,
                sites: creatorsResponseModel.urls
            )
        )
    }
    
    private func getEventsDetailsViewModel(with eventsResponseModel: EventsResponseModel) -> DetailsViewModel {
        return DetailsViewModel(
            image: getImageURL(
                path: eventsResponseModel.thumbnail?.path,
                pathExtension: eventsResponseModel.thumbnail?.thumbnailExtension
            ),
            name: eventsResponseModel.title,
            description: eventsResponseModel.description,
            lists: getLists(
                characters: eventsResponseModel.characters,
                comics: eventsResponseModel.comics,
                creators: eventsResponseModel.creators,
                events: nil,
                series: eventsResponseModel.series,
                sites: eventsResponseModel.urls
            )
        )
    }
    
    private func getSeriesDetailsViewModel(with seriesResponseModel: SeriesResponseModel) -> DetailsViewModel {
        return DetailsViewModel(
            image: getImageURL(
                path: seriesResponseModel.thumbnail?.path,
                pathExtension: seriesResponseModel.thumbnail?.thumbnailExtension
            ),
            name: seriesResponseModel.title,
            description: seriesResponseModel.description,
            lists: getLists(
                characters: seriesResponseModel.characters,
                comics: seriesResponseModel.comics,
                creators: seriesResponseModel.creators,
                events: seriesResponseModel.events,
                series: nil,
                sites: seriesResponseModel.urls
            )
        )
    }
    
    private func getImageURL(path: String?, pathExtension: String?) -> String? {
        if let path = path, let pathExtension = pathExtension {
            return "\(path)/standard_xlarge.\(pathExtension)"
        }
        return nil
    }
    
    private func getLists(
        characters: ListResponseModel?,
        comics: ListResponseModel?,
        creators: ListResponseModel?,
        events: ListResponseModel?,
        series: ListResponseModel?,
        sites: [URLResponseModel]?) -> [ListViewModel]? {
            
            var list: [ListViewModel] = []
            
            if let characters = characters, !characters.items.isEmpty {
                list.append(ListViewModel(type: .plainText, title: "CHARACTERS", items: getItems(characters.items)))
            }
            
            if let comics = comics, !comics.items.isEmpty {
                list.append(ListViewModel(type: .plainText, title: "COMICS", items: getItems(comics.items)))
            }
            
            if let creators = creators, !creators.items.isEmpty {
                list.append(ListViewModel(type: .plainText, title: "CREATORS", items: getItems(creators.items)))
            }
            
            if let events = events, !events.items.isEmpty {
                list.append(ListViewModel(type: .plainText, title: "EVENTS", items: getItems(events.items)))
            }
            
            if let series = series, !series.items.isEmpty {
                list.append(ListViewModel(type: .plainText, title: "SERIES", items: getItems(series.items)))
            }
            
            if let sites = sites, !sites.isEmpty {
                list.append(ListViewModel(type: .link, title: "SITES", items: getSites(sites)))
            }
            
            return list
            
        }
    
    private func getItems(_ items: [Items]) -> [String] {
        var itemsInString: [String] = []
        items.forEach { item in
            itemsInString.append(item.name)
        }
        return itemsInString
    }
    
    private func getSites(_ sites: [URLResponseModel]) -> [String] {
        var sitesList: [String] = []
        sites.forEach { site in
            if let url = site.url {
                sitesList.append(url)
            }
        }
        return sitesList
    }
}
