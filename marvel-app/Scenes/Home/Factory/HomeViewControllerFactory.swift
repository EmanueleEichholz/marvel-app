//
//  CharacterListFactory.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import Foundation

final class HomeViewControllerFactory {
    
    static func getHomeViewController(coordinator: HomeCoordinatorProtocol) -> HomeViewController {
        
        let presenter = HomePresenter()
        let worker = HomeWorker()
        let interactor = HomeInteractor(coordinator: coordinator,
                                        presenter: presenter,
                                        worker: worker)
        
        let viewController = HomeViewController(interactor: interactor)
        presenter.view = viewController
        return viewController
    }
}
