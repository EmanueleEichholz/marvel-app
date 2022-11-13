//
//  CharacterListPresenter.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import Foundation

protocol HomePresenterProtocol {
    func presentCharacters(with model: CharacterListResponseModel)
}

final class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewControllerProtocol?

    func presentCharacters(with model: CharacterListResponseModel) {
        var characterList: [CharacterModel] = []
        model.results.forEach { character in
            characterList.append(
                CharacterModel(
                    name: character.name ?? "Nome indisponível",
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
        return "https://i.pinimg.com/564x/a0/f3/50/a0f3505663685be97b3ba48694325f0c.jpg"
    }
}
