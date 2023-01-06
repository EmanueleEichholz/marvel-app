//
//  CharacterCell.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 06/11/22.
//

import UIKit

final class ItemCell: UICollectionViewCell {
    
    private lazy var itemCard: ItemCard = {
        let view = ItemCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateView(with model: ItemCardModel) {
        itemCard.updateView(with: model)
    }
    
    private func setupLayout() {
        addSubview(itemCard)
        let cellSize = round((UIScreen.main.bounds.width - 48)/2.5)
        NSLayoutConstraint.activate([
            itemCard.topAnchor.constraint(equalTo: topAnchor),
            itemCard.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemCard.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemCard.bottomAnchor.constraint(equalTo: bottomAnchor),
            itemCard.heightAnchor.constraint(equalToConstant: cellSize),
            itemCard.widthAnchor.constraint(equalToConstant: cellSize)
        ])
    }
}
