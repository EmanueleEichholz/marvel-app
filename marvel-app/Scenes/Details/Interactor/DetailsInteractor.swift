//
//  DetailsInteractor.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 04/01/23.
//

import Foundation

protocol DetailsInteractorProtocol {
    func viewDidLoad()
    func didTapBackButton()
}

final class DetailsInteractor {
    
    private let coordinator: DetailsCoordinatorProtocol
    private let presenter: DetailsPresenterProtocol
    private let detailsModel: GenericResponseModel
    
    init(
        coordinator: DetailsCoordinatorProtocol,
        presenter: DetailsPresenterProtocol,
        detailsModel: GenericResponseModel
    ) {
        self.coordinator = coordinator
        self.presenter = presenter
        self.detailsModel = detailsModel
    }
      
}

extension DetailsInteractor: DetailsInteractorProtocol {
    func viewDidLoad() {
        presenter.presentDetails(detailsModel: detailsModel)
    }
    
    func didTapBackButton() {
        coordinator.didTapBackButton()
    }
}
