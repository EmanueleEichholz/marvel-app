//
//  CharacterListInteractor.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import Foundation

protocol HomeInteractorProtocol {
    func viewDidLoad()
}

final class HomeInteractor: HomeInteractorProtocol {
    
    private let coordinator: HomeCoordinatorProtocol
    private let presenter: HomePresenterProtocol
    private let worker: HomeWorkerProtocol
    
    init(coordinator: HomeCoordinatorProtocol,
         presenter: HomePresenterProtocol,
         worker: HomeWorkerProtocol) {
        self.coordinator = coordinator
        self.presenter = presenter
        self.worker = worker
    }
    
    func viewDidLoad() {
        getCharacters()
    }
    
    private func getCharacters() {
        print("get characters")
        worker.getCharactersInfo(completion: { result in
            switch result {
            case .success(let response):
                guard let data = response.data else { return }
                self.presenter.presentCharacters(with: data)
            case .failure(let error):
                print(error)
            }
        })
    }
}
