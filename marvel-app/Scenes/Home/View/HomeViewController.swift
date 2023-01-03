//
//  CharacterListViewController.swift
//  marvel-app
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func updateCharactersSection(with charactersInfo: [ItemCardModel])
//    func updateComicsSection(with comicsInfo: HorizontalCollectionModel)
//    func updateCreatorsSection(with creatorsInfo: HorizontalCollectionModel)
//    func updateEventsSection(with eventsInfo: HorizontalCollectionModel)
//    func updateStoriesSection(with storiesInfo: HorizontalCollectionModel)
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
    
    func updateCharactersSection(with charactersInfo: [ItemCardModel]) {
        homeView.updateCharactersSection(with: charactersInfo)
    }
    
//    func updateComicsSection(with comicsInfo: HorizontalCollectionModel) {
//        homeView.updateComicsSection(with: comicsInfo)
//    }
//
//    func updateCreatorsSection(with creatorsInfo: HorizontalCollectionModel) {
//        homeView.updateCreatorsSection(with: creatorsInfo)
//    }
//
//    func updateEventsSection(with eventsInfo: HorizontalCollectionModel) {
//        homeView.updateEventsSection(with: eventsInfo)
//    }
//
//    func updateStoriesSection(with storiesInfo: HorizontalCollectionModel) {
//        homeView.updateStoriesSection(with: storiesInfo)
//    }
    
}
