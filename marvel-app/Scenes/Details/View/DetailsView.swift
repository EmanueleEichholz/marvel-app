//
//  DetailsView.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 04/01/23.
//

import UIKit

protocol DetailsViewDelegateProtocol: AnyObject {
    func didTapBackButton()
}

final class DetailsView: UIView {
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.updateView(
            with: HeaderViewModel(
                leftIcon: UIImage(
                    systemName: "chevron.left"
                ),
                logo: .marvelLogo,
                rightIcon: nil,
                iconColor: .marvelWhite
            )
        )
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "deadpool-question-mark")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.setVerticalLinearGradient(startPoint: 1.0, endPoint: 0.50)
        return imageView
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .marvelWhite
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .marvelWhite
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var listView: ListView = {
        let view = ListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: DetailsViewDelegateProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateDetailsView(with model: DetailsViewModel) {
        containerStackView.removeAllSubviews()
        
        if let image = model.image {
            itemImageView.imageFromURL(urlString: image)
            containerStackView.addArrangedSubview(itemImageView)
        }


        if let name = model.name {
            itemNameLabel.text = name
            containerStackView.addArrangedSubview(itemNameLabel)
        }
        
        if let description = model.description {
            itemDescriptionLabel.text = description
            containerStackView.addArrangedSubview(itemDescriptionLabel)
        }

        if let lists = model.lists {
            lists.forEach { list in
                let view = ListView()
                view.updateView(with: list)
                containerStackView.addArrangedSubview(view)
            }
        }
        
        self.layoutIfNeeded()
    }
    
    private func setupLayout() {
        backgroundColor = .marvelBlack
        addSubview(headerView)
        addSubview(scrollView)
        scrollView.addSubview(containerStackView)
        
        let imageSize = (UIScreen.main.bounds.width - 32)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),

            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0),
            containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.0),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            itemImageView.widthAnchor.constraint(equalToConstant: imageSize),
            itemImageView.heightAnchor.constraint(equalToConstant: imageSize),
        ])
    }
    
}

extension DetailsView: HeaderViewClickDelegateProtocol {
    func didTapLeftButton() {
        delegate?.didTapBackButton()
    }
}


