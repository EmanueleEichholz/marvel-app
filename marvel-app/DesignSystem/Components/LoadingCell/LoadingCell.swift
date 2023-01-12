//
//  LoadingCell.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 06/01/23.
//

import UIKit

final class LoadingCell: UICollectionViewCell {
    
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10.0
        view.backgroundColor = .marvelDarkGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        DispatchQueue.main.async {
            self.loadingView.startShimmering()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupLayout() {
        addSubview(loadingView)
        let cellSize = round((UIScreen.main.bounds.width - 48)/2.5)
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: cellSize),
            loadingView.widthAnchor.constraint(equalToConstant: cellSize)
        ])
    }
}
