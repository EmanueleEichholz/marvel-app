//
//  CharacterListFactory.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import Foundation

final class HomeViewControllerFactory {
    
    static func getHomeViewController(coordinator: HomeCoordinatorProtocol) -> HomeViewController {
        let interactor = HomeInteractor(coordinator: coordinator,
                                        presenter: HomePresenter(),
                                        worker: HomeWorker())
        let viewController = HomeViewController(interactor: interactor)
        return viewController
    }
}
