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

final class ApplicationCoordinator: Coordinator, HomeCoordinatorProtocol {

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
    
    func presentHome() {
        let viewController = HomeViewControllerFactory.getHomeViewController(coordinator: self)
        navigationController.present(viewController, animated: true)
    }
    
    func didTapBackButton() {
        print("oi")
    }
    
    func didTapCharacter() {
        print("oi")
    }
    
}
