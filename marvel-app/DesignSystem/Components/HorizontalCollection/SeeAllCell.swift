//
//  SeeAllCell.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 20/12/22.
//


import UIKit

final class SeeAllCell: UICollectionViewCell {
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textLabel, arrowImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 8.0
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .marvelWhite
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "See all"
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .left
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .marvelWhite
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        let cellSize = round((UIScreen.main.bounds.width - 48)/2.5)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStackView.heightAnchor.constraint(equalToConstant: cellSize),
            containerStackView.widthAnchor.constraint(equalToConstant: cellSize)
        ])
    }
}
