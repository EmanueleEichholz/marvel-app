//
//  CharacterListViewController.swift
//  marvel-app
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func showCharacters(characterList: [CharacterModel])
}

final class HomeViewController: UIViewController {

    private var homeView: HomeView = HomeView()
    private let interactor: HomeInteractorProtocol
    
    init(interactor: HomeInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Cannot init from decoder")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    
    func showCharacters(characterList: [CharacterModel]) {
        homeView.showCharacters(characterList: characterList)
    }
}
