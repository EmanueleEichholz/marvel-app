//
//  CharacterListPresenter.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import Foundation

protocol HomePresenterProtocol {
    func presentCharacters(with model: CharacterListResponseModel?)
}

class HomePresenter: HomePresenterProtocol {

    weak var view: HomeViewControllerProtocol?
    
    func presentCharacters(with model: CharacterListResponseModel?) {
        guard let model = model else { return }
        var characterList: [CharacterModel] = []
        model.results.forEach { character in
            characterList.append(
                CharacterModel(
                    name: character.name ?? "Name Unavailable",
                    image: getImageURL(
                        path: character.thumbnail?.path,
                        pathExtension: character.thumbnail?.thumbnailExtension
                    )
                )
            )
        }
        view?.showCharacters(characterList: characterList)
    }
    
    private func getImageURL(path: String?, pathExtension: String?) -> String {
        if let path = path, let pathExtension = pathExtension {
            return "\(path)/standard_xlarge.\(pathExtension)"
        }
        return ""
    }
}
