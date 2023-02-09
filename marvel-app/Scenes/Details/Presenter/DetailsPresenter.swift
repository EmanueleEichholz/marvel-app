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
    
    private func getCharactersDetailsViewModel(with responseModel: CharacterResponseModel) -> DetailsViewModel {
        return DetailsViewModel(
            image: getImageURL(
                path: responseModel.thumbnail?.path,
                pathExtension: responseModel.thumbnail?.thumbnailExtension
            ),
            name: responseModel.name,
            description: responseModel.description,
            lists: getLists(
                characters: nil,
                comics: responseModel.comics,
                creators: nil,
                events: responseModel.events,
                series: responseModel.series,
                sites: responseModel.urls
            )
        )
    }
    
    private func getComicsDetailsViewModel(with responseModel: ComicsResponseModel) -> DetailsViewModel {
        return DetailsViewModel(
            image: getImageURL(
                path: responseModel.thumbnail?.path,
                pathExtension: responseModel.thumbnail?.thumbnailExtension
            ),
            name: responseModel.title,
            description: responseModel.description,
            lists: getLists(
                characters: responseModel.characters,
                comics: nil,
                creators: responseModel.creators,
                events: responseModel.events,
                series: nil,
                sites: responseModel.urls
            )
        )
    }
    
    private func getCreatorsDetailsViewModel(with responseModel: CreatorsResponseModel) -> DetailsViewModel {
        return DetailsViewModel(
            image: getImageURL(
                path: responseModel.thumbnail?.path,
                pathExtension: responseModel.thumbnail?.thumbnailExtension
            ),
            name: responseModel.fullName,
            description: nil,
            lists: getLists(
                characters: nil,
                comics: responseModel.comics,
                creators: nil,
                events: responseModel.events,
                series: responseModel.series,
                sites: responseModel.urls
            )
        )
    }
    
    private func getEventsDetailsViewModel(with responseModel: EventsResponseModel) -> DetailsViewModel {
        return DetailsViewModel(
            image: getImageURL(
                path: responseModel.thumbnail?.path,
                pathExtension: responseModel.thumbnail?.thumbnailExtension
            ),
            name: responseModel.title,
            description: responseModel.description,
            lists: getLists(
                characters: responseModel.characters,
                comics: responseModel.comics,
                creators: nil,
                events: nil,
                series: responseModel.series,
                sites: responseModel.urls
            )
        )
    }
    
    private func getSeriesDetailsViewModel(with responseModel: SeriesResponseModel) -> DetailsViewModel {
        return DetailsViewModel(
            image: getImageURL(
                path: responseModel.thumbnail?.path,
                pathExtension: responseModel.thumbnail?.thumbnailExtension
            ),
            name: responseModel.title,
            description: responseModel.description,
            lists: getLists(
                characters: responseModel.characters,
                comics: responseModel.comics,
                creators: responseModel.creators,
                events: responseModel.events,
                series: nil,
                sites: responseModel.urls
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
        sites: [URLResponseModel]?) -> ListsViewModel {
        
        var itemsList: [ItemsListViewModel] = []
        var sitesList: [SitesListViewModel] = []
        
        if let characters = characters, !characters.items.isEmpty {
            itemsList.append(ItemsListViewModel(title: "CHARACTERS", items: getItems(characters.items)))
        }
        
        if let comics = comics, !comics.items.isEmpty {
            itemsList.append(ItemsListViewModel(title: "COMICS", items: getItems(comics.items)))
        }
        
        if let creators = creators, !creators.items.isEmpty {
            itemsList.append(ItemsListViewModel(title: "CREATORS", items: getItems(creators.items)))
        }
        
        if let events = events, !events.items.isEmpty {
            itemsList.append(ItemsListViewModel(title: "EVENTS", items: getItems(events.items)))
        }
        
        if let series = series, !series.items.isEmpty {
            itemsList.append(ItemsListViewModel(title: "SERIES", items: getItems(series.items)))
        }
        
        if let sites = sites, !sites.isEmpty {
            sitesList.append(SitesListViewModel(title: "SITES", sitesList: getSites(sites)))
        }
        
        return ListsViewModel(
            itemsList: itemsList,
            sitesList: sitesList
        )
    }
    
    private func getItems(_ items: [Items]) -> [String] {
        return items.map { item in
            return item.name
        }
    }
    
    private func getSites(_ sites: [URLResponseModel]) -> [SiteViewModel] {
        return sites.map { site in
            return SiteViewModel(
                siteTitle: site.type,
                siteUrl: site.url
            )
        }
    }
}
