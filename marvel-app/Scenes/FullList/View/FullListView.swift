//
//  FullListView.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import UIKit

protocol FullListViewDelegateProtocol: AnyObject {
    func didTapBackButton()
}

final class FullListView: UIView {

    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.updateView(with: HeaderViewModel(
                leftIcon: UIImage(systemName: "chevron.left"),
                logo: .marvelLogo,
                rightIcon: nil,
                iconColor: .marvelWhite)
        )
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .marvelWhite
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "LOADING..."
        return label
    }()
    
    private lazy var verticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cellSize = (UIScreen.main.bounds.width - 50)/2
        layout.estimatedItemSize = CGSize(width: cellSize, height: cellSize)
        layout.minimumLineSpacing = 16.0
        layout.minimumInteritemSpacing = 16.0
        layout.scrollDirection = .vertical

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ItemVerticalCollectionViewCell.self, forCellWithReuseIdentifier: ItemVerticalCollectionViewCell.identifier)
        collection.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = true
        collection.backgroundColor = .clear
        return collection
    }()
    
    weak var delegate: FullListViewDelegateProtocol?
    private var itemList: [ItemCardModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        setupAdditinalLayoutSettings()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubviews() {
        addSubviews(headerView, titleLabel, verticalCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            
            verticalCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16.0),
            verticalCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            verticalCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            verticalCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
        ])
    }
    
    private func setupAdditinalLayoutSettings() {
        backgroundColor = .marvelBlack
    }
    
    func updateView(with model: FullListViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = model.title
            self?.itemList = model.itemList
            self?.verticalCollectionView.reloadData()
        }
    }
    
}

extension FullListView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.isEmpty ? 9 : itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if itemList.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LoadingCell.identifier,
                for: indexPath) as? LoadingCell else {
                return UICollectionViewCell()
            }
            
            cell.updateView(with: round((UIScreen.main.bounds.width - 50)/2))
            return cell
        }
        
        guard let cell = verticalCollectionView.dequeueReusableCell(
            withReuseIdentifier: ItemVerticalCollectionViewCell.identifier,
            for: indexPath
        ) as? ItemVerticalCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.updateView(with: itemList[indexPath.row])
        return cell
    }
    
}

extension FullListView: HeaderViewClickDelegateProtocol {
    func didTapLeftButton() {
        delegate?.didTapBackButton()
    }
}
