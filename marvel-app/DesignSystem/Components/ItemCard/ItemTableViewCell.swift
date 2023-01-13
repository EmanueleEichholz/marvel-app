//
//  ItemTableViewCell.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
    
    private lazy var itemCard: ItemCard = {
        let view = ItemCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        let cellSize = round((UIScreen.main.bounds.width - 64)/3)
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
