//
//  CharacterCell.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 06/11/22.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
    
    private lazy var characterCard: CharacterCard = {
        let view = CharacterCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupUpperCollectionCell(with viewModel: CharacterViewModel) {
        characterCard.updateView(with: viewModel)
        updateLayoutUpperCollectionCell()
    }
    
    func setupBottomCollectionCell(with viewModel: CharacterViewModel) {
        characterCard.updateView(with: viewModel)
        updateLayoutBottomCollectionCell()
    }
    
    private func setupInitialLayout() {
        addSubview(characterCard)
        NSLayoutConstraint.activate([
            characterCard.topAnchor.constraint(equalTo: topAnchor),
            characterCard.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterCard.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterCard.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func updateLayoutUpperCollectionCell() {
        let cellSize = (UIScreen.main.bounds.width - 48)/2.5
        NSLayoutConstraint.activate([
            characterCard.heightAnchor.constraint(equalToConstant: cellSize),
            characterCard.widthAnchor.constraint(equalToConstant: cellSize),
        ])
    }
    
    private func updateLayoutBottomCollectionCell() {
        let cellSize = (UIScreen.main.bounds.width - 65)/3
        NSLayoutConstraint.activate([
            characterCard.heightAnchor.constraint(equalToConstant: cellSize),
            characterCard.widthAnchor.constraint(equalToConstant: cellSize),
        ])
    }
}
