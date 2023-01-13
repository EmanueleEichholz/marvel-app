//
//  FullListInteractor.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import Foundation

protocol FullListInteractorProtocol {
    func viewDidLoad()
    func didTapBackButton()
}

final class FullListInteractor {
    
    private let coordinator: FullListCoordinatorProtocol
    private let presenter: FullListPresenterProtocol
    private let worker: FullListWorkerProtocol
    
    init(
        coordinator: FullListCoordinatorProtocol,
        presenter: FullListPresenterProtocol,
        worker: FullListWorkerProtocol
    ) {
        self.coordinator = coordinator
        self.presenter = presenter
        self.worker = worker
    }
    
}

extension FullListInteractor: FullListInteractorProtocol {
    
    func viewDidLoad() {
        
    }
    
    func didTapBackButton() {
        coordinator.didTapBackButton()
    }
    
}
