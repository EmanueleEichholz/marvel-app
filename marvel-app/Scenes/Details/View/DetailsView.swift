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
        view.updateView(with: HeaderViewModel(leftIcon: UIImage(systemName: "chevron.left"), logo: .marvelLogo, rightIcon: nil, iconColor: .white))
        return view
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    weak var delegate: DetailsViewDelegateProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func updateDetailsView(with detailsInfo: String) {
//        DispatchQueue.main.async { [weak self] in
//
//        }
    }
    
    private func setupLayout() {
        backgroundColor = .marvelBlack
        addSubviews(headerView, containerStackView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            containerStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8.0),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
        ])
    }
    
}

extension DetailsView: HeaderViewClickDelegateProtocol {
    func didTapLeftButton() {
        delegate?.didTapBackButton()
    }
}


