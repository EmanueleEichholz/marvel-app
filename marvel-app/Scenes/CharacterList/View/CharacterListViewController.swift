//
//  CharacterListViewController.swift
//  marvel-app
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import UIKit

final class CharacterListViewController: UIViewController {
    
    private var characterListView: CharacterListView = CharacterListView()
    let worker = CharacterListWorker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .marvelBlack
        worker.getCharactersInfo(completion: { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    override func loadView() {
        super.loadView()
        view = characterListView
    }

}

