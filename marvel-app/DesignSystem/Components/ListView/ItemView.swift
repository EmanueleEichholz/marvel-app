//
//  ItemView.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 06/01/23.
//

import UIKit

final class ItemView: UIView {
    
    private lazy var plainTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .marvelWhite
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var siteTouchableView: UIControl = {
        let view = UIControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(siteLinkLabel)
        view.addTarget(self, action: #selector(siteURLTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var siteLinkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .link
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var siteLink: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func siteURLTapped() {
        if let siteLink = siteLink, let url = URL(string: siteLink) {
            UIApplication.shared.open(url)
        }
    }
    
    func updateView(text: String?, url: String? = nil) {
        guard let text else { return }
        
        if let url = url {
            self.siteLink = url
            setupSiteLinkLayout()
            siteLinkLabel.text = text.capitalized
            siteLinkLabel.underline()
        } else {
            setupPlainTextLayout()
            plainTextLabel.text = "- \(text)"
        }
    }
    
    private func setupPlainTextLayout() {
        addSubview(plainTextLabel)
        NSLayoutConstraint.activate([
            plainTextLabel.topAnchor.constraint(equalTo: topAnchor),
            plainTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            plainTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            plainTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupSiteLinkLayout() {
        addSubview(siteTouchableView)
        siteTouchableView.addSubview(siteLinkLabel)
        NSLayoutConstraint.activate([
            siteTouchableView.topAnchor.constraint(equalTo: topAnchor),
            siteTouchableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            siteTouchableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            siteTouchableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            siteLinkLabel.topAnchor.constraint(equalTo: siteTouchableView.topAnchor),
            siteLinkLabel.leadingAnchor.constraint(equalTo: siteTouchableView.leadingAnchor),
            siteLinkLabel.trailingAnchor.constraint(equalTo: siteTouchableView.trailingAnchor),
            siteLinkLabel.bottomAnchor.constraint(equalTo: siteTouchableView.bottomAnchor),
        ])
    }
}
