//
//  ErrorCell.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 06/01/23.
//

import UIKit

final class ErrorCard: UIView {
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [errorTextLabel, arrowClockwiseImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 16.0
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    private lazy var errorTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .marvelRed
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var arrowClockwiseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.image = UIImage(systemName: "arrow.clockwise")
        imageView.tintColor = .marvelRed
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
    
    func updateView(text: String) {
        errorTextLabel.text = text
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        self.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            containerStackView.heightAnchor.constraint(equalToConstant: 100.0),
            containerStackView.widthAnchor.constraint(equalToConstant: 200.0)
        ])
    }
}
