//
//  DetailsPresenter.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 04/01/23.
//

import Foundation

protocol DetailsPresenterProtocol {
    func presentDetails<T>(detailsModel: T)
}

final class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewControllerProtocol?
    
    func presentDetails<T>(detailsModel: T) {
        view?.updateDetailsView(with: "oi")
    }
}
