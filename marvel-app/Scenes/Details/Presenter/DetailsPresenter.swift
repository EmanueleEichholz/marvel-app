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
        if detailsModel is CharacterResponseModel {
            
            return
        }
        
        if detailsModel is ComicsResponseModel {
            
        }
        
        view?.updateDetailsView(with: "oi")
    }
    
    private func updateView(with characters: CharacterResponseModel) {
        
    }
}
