//
//  Coordinator.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

final class ApplicationCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.modalPresentationStyle = .fullScreen
    }
    
    func start() {
        let viewController = HomeViewControllerFactory.getHomeViewController(coordinator: self)
        navigationController.setViewControllers([viewController], animated: false)
    }
}

extension ApplicationCoordinator: HomeCoordinatorProtocol {

    func didTapBackButton() {
        navigationController.popViewController(animated: true)
    }
    
    func goToDetailsScreen(detailsInfo: GenericResponseModel) {
        let viewController = DetailsViewControllerFactory.getDetailsViewController(coordinador: self, detailsModel: detailsInfo)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func didTapSeeAll() {
        print("clicou para ver a lista completa")
    }
    
}

extension ApplicationCoordinator: DetailsCoordinatorProtocol {
    func didTapToOpenSite(url: String) {

    }
}
