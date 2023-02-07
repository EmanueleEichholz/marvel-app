//
//  FullListViewController.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import UIKit

protocol FullListViewControllerProtocol: AnyObject {
    func updateView(with model: FullListViewModel)
    func updateAlert(with alert: AlertModel)
}

final class FullListViewController: UIViewController {
    
    private var fullListView: FullListView = FullListView()
    private let interactor: FullListInteractorProtocol
    
    init(interactor: FullListInteractorProtocol) {
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
        view = fullListView
        fullListView.delegate = self
    }
    
}

extension FullListViewController: FullListViewControllerProtocol {

    func updateView(with model: FullListViewModel) {
        fullListView.updateView(with: model)
    }
    
    func updateAlert(with alert: AlertModel) {
        self.showAlert(model: alert) {
                self.interactor.searchButtonClicked(searchBarContent: nil)
            } secondButtonAction: {
                self.interactor.backButtonTapped()
            }
    }

}

extension FullListViewController: FullListViewDelegateProtocol {
    
    func scrolledForMoreItems(searchBarContent: String?) {
        interactor.scrolledForMoreItems(searchBarContent: searchBarContent)
    }
    
    func searchButtonClicked(searchBarContent: String?) {
        interactor.searchButtonClicked(searchBarContent: searchBarContent)
    }
    
    func backButtonTapped() {
        interactor.backButtonTapped()
    }
    
}


