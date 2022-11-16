//
//  CharacterCard.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import UIKit

final class CharacterCard: UIView {
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "deadpool-question-mark")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        imageView.setVerticalLinearGradient(startPoint: 1.0, endPoint: 0.50)
        return imageView
    }()
    
    private lazy var characterNameLabel: UILabel = {
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
    
    func updateView(with model: CharacterModel) {
        characterNameLabel.text = model.name
        characterImage.imageFromURL(urlString: model.image)
    }
    
    private func setupLayout() {
        addSubview(characterImage)
        characterImage.addSubviews(characterNameLabel)
        NSLayoutConstraint.activate([
            
            characterImage.topAnchor.constraint(equalTo: topAnchor),
            characterImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterImage.bottomAnchor.constraint(equalTo: bottomAnchor),

            characterNameLabel.leadingAnchor.constraint(equalTo: characterImage.leadingAnchor, constant: 8),
            characterNameLabel.trailingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: -8),
            characterNameLabel.bottomAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: -8),
        ])
    }
}
