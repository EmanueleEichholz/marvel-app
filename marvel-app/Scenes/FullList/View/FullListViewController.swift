//
//  FullListViewController.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import UIKit

protocol FullListViewControllerProtocol: AnyObject {
    
}

final class FullListViewController: UIViewController {
    
    private var fullListView: FullListView = FullListView()
    private let interactor: FullListInteractorProtocol
    private let listType: ListTypeEnum
    
    init(interactor: FullListInteractorProtocol, with listType: ListTypeEnum) {
        self.interactor = interactor
        self.listType = listType
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
    
}

extension FullListViewController: FullListViewDelegateProtocol {
    
    func didTapBackButton() {
        interactor.didTapBackButton()
    }
    
}


