//
//  DetailsViewController.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 04/01/23.
//

import UIKit

protocol DetailsViewControllerProtocol: AnyObject {
    func updateDetailsView(with detailsInfo: DetailsViewModel)
}

final class DetailsViewController: UIViewController {
    
    private var detailsView: DetailsView = DetailsView()
    private let interactor: DetailsInteractorProtocol
    
    init(interactor: DetailsInteractorProtocol) {
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
        detailsView.delegate = self
        view = detailsView
    }
    
}

extension DetailsViewController: DetailsViewControllerProtocol {
    
    func updateDetailsView(with model: DetailsViewModel) {
        detailsView.updateDetailsView(with: model)
    }
    
}

extension DetailsViewController: DetailsViewDelegateProtocol {
    
    func didTapBackButton() {
        interactor.didTapBackButton()
    }
}

