//
//  CharacterCard.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import UIKit

final class ItemCard: UIView {
    
    private lazy var itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "deadpool-question-mark")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        imageView.setVerticalLinearGradient(startPoint: 1.0, endPoint: 0.50)
        return imageView
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .marvelWhite
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func updateView(with model: ItemCardModel) {
        itemNameLabel.text = model.name
        itemImage.imageFromURL(urlString: model.image)
    }
    
    private func setupLayout() {
        addSubview(itemImage)
        itemImage.addSubviews(itemNameLabel)
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: topAnchor),
            itemImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemImage.bottomAnchor.constraint(equalTo: bottomAnchor),

            itemNameLabel.leadingAnchor.constraint(equalTo: itemImage.leadingAnchor, constant: 8),
            itemNameLabel.trailingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: -8),
            itemNameLabel.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: -8),
        ])
    }
    
}
