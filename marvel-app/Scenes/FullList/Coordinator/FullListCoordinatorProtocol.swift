//
//  FullListCoordinatorProtocol.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import Foundation

protocol FullListCoordinatorProtocol {
    func didTapBackButton()
    func goToDetailsScreen(detailsInfo: GenericResponseModel)
}
