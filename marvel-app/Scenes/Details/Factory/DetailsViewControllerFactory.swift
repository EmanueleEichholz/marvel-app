//
//  DetailsFactory.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 04/01/23.
//

import Foundation

final class DetailsViewControllerFactory {
    
    static func getDetailsViewController(coordinador: DetailsCoordinatorProtocol, detailsModel: GenericResponseModel) -> DetailsViewController {
        let presenter = DetailsPresenter()
        let interactor = DetailsInteractor(
            coordinator: coordinador,
            presenter: presenter,
            detailsModel: detailsModel
        )
        let viewController = DetailsViewController(interactor: interactor)
        presenter.view = viewController
        return viewController
    }
}
