//
//  ListView.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 05/01/23.
//

import UIKit

final class ListView: UIView {
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8.0
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .marvelWhite
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateView(with model: ListViewModel) {
        containerStackView.removeAllSubviews()
        
        titleLabel.text = model.title
        containerStackView.addArrangedSubview(titleLabel)

        model.items.forEach { item in
            let itemView = ItemView()
            itemView.updateView(text: item, type: model.type)
            containerStackView.addArrangedSubview(itemView)
        }
        containerStackView.setCustomSpacing(16.0, after: titleLabel)
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
