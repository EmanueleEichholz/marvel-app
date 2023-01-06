//
//  HeaderView.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 06/11/22.
//

import UIKit

protocol HeaderViewClickDelegateProtocol: AnyObject {
    func didTapLeftButton()
    func didTapRightButton()
}

extension HeaderViewClickDelegateProtocol {
    func didTapLeftButton() { /* Extension for optional implementation */ }
    func didTapRightButton() { /* Extension for optional implementation */ }
}

final class HeaderView: UIView {
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var rightTouchableView: UIControl = {
        let view = UIControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(rightIconTapped), for: .touchUpInside)
        view.contentMode = .right
        return view
    }()
    
    private lazy var leftTouchableView: UIControl = {
        let view = UIControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(leftIconTapped), for: .touchUpInside)
        view.contentMode = .left
        return view
    }()
    
    private lazy var rightIconImageView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .right
        return icon
    }()
    
    private lazy var leftIconImageView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .left
        return icon
    }()
    
    weak var delegate: HeaderViewClickDelegateProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func rightIconTapped() {
        delegate?.didTapRightButton()
    }
    
    @objc private func leftIconTapped() {
        delegate?.didTapLeftButton()
    }
    
    func updateView(with viewModel: HeaderViewModel) {
        rightIconImageView.image = viewModel.rightIcon
        rightIconImageView.tintColor = viewModel.iconColor
        
        logoImageView.image = viewModel.logo
        
        leftIconImageView.image = viewModel.leftIcon
        leftTouchableView.tintColor = viewModel.iconColor
        
    }
    
    private func setupLayout() {
        addSubviews(rightTouchableView, logoImageView, leftTouchableView)
        rightTouchableView.addSubview(rightIconImageView)
        leftTouchableView.addSubview(leftIconImageView)
        
        NSLayoutConstraint.activate([
            leftTouchableView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            leftTouchableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            leftTouchableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
            leftTouchableView.heightAnchor.constraint(equalToConstant: 40.0),
            leftTouchableView.widthAnchor.constraint(equalToConstant: 40.0),
            
            leftIconImageView.leadingAnchor.constraint(equalTo: leftTouchableView.leadingAnchor),
            leftIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftIconImageView.heightAnchor.constraint(equalToConstant: 24.0),
            leftIconImageView.widthAnchor.constraint(equalToConstant: 24.0),
            
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 72.0),
            
            rightTouchableView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            rightTouchableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            rightTouchableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
            rightTouchableView.heightAnchor.constraint(equalToConstant: 40.0),
            rightTouchableView.widthAnchor.constraint(equalToConstant: 40.0),
            
            rightIconImageView.trailingAnchor.constraint(equalTo: rightTouchableView.trailingAnchor),
            rightIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightIconImageView.heightAnchor.constraint(equalToConstant: 24.0),
            rightIconImageView.widthAnchor.constraint(equalToConstant: 24.0),
            
        ])
    }
    
}
