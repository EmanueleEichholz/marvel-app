//
//  CharacterListCoordinatorProtocol.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import Foundation

protocol HomeCoordinatorProtocol {
    func didTapBackButton()
    func goToDetailsScreen(detailsInfo: GenericResponseModel)
    func didTapSeeAll(listType: ListTypeEnum)
}
