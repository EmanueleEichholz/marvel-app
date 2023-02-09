//
//  ListViewModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 05/01/23.
//

import Foundation

struct ListsViewModel {
    let itemsList: [ItemsListViewModel]?
    let sitesList: [SitesListViewModel]?
}

struct  ItemsListViewModel {
    let title: String
    let items: [String]
}

struct SitesListViewModel {
    let title: String
    let sitesList: [SiteViewModel]
}

struct SiteViewModel {
    let siteTitle: String?
    let siteUrl: String?
}


