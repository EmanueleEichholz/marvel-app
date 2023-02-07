//
//  FullListViewControllerFactory.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import Foundation

final class FullListViewControllerFactory {
    
    static func getFullListViewController(coordinator: FullListCoordinatorProtocol, with listType: ListTypeEnum) -> FullListViewController {
        
        let presenter = FullListPresenter()
        let worker = FullListWorker(with: NetworkRequest())
        
        let interactor = FullListInteractor(
            coordinator: coordinator,
            presenter: presenter,
            worker: worker,
            listType: listType
        )
        
        let viewController = FullListViewController(interactor: interactor)
        presenter.view = viewController
        return viewController
    }
}
