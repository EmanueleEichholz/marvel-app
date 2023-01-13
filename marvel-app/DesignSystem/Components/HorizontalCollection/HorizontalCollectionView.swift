//
//  HorizontalSection.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 16/12/22.
//

import UIKit

protocol HorizontalCollectionViewDelegate: AnyObject {
    func didSelectItem(sectionIndex: Int?, itemIndex: Int?)
}

final class HorizontalCollectionView: UITableViewCell {
    
    private lazy var horizontalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cellSize = round((UIScreen.main.bounds.width - 48)/2.5)
        layout.estimatedItemSize = CGSize(width: cellSize, height: cellSize)
        layout.minimumLineSpacing = 16.0
        layout.minimumInteritemSpacing = 16.0
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        collection.register(SeeAllCell.self, forCellWithReuseIdentifier: SeeAllCell.identifier)
        collection.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = true
        collection.backgroundColor = .clear
        return collection
    }()
    
    private var itemList: [ItemCardModel] = []
    private var sectionIndex: Int?
    weak var delegate: HorizontalCollectionViewDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateView(with itemList: [ItemCardModel], sectionIndex: Int?) {
        self.sectionIndex = sectionIndex
        self.itemList = itemList
        DispatchQueue.main.async { [weak self] in
            self?.horizontalCollectionView.reloadData()
        }
    }
    
    private func setupLayout() {
        let collectionHeight = round((UIScreen.main.bounds.width - 48)/2.5)
        self.backgroundColor = .marvelBlack
        self.selectionStyle = .none
        contentView.addSubview(horizontalCollectionView)
        NSLayoutConstraint.activate([
            horizontalCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horizontalCollectionView.heightAnchor.constraint(equalToConstant: collectionHeight)
        ])
    }
}

extension HorizontalCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.isEmpty ? 3 : (itemList.count + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if itemList.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LoadingCell.identifier,
                for: indexPath) as? LoadingCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
        if indexPath.row < itemList.count {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ItemCollectionViewCell.identifier,
                for: indexPath) as? ItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.updateView(with: itemList[indexPath.row])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SeeAllCell.identifier,
                for: indexPath) as? SeeAllCell else {
                return UICollectionViewCell()
            }
            return cell
        }
    }
}

extension HorizontalCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(sectionIndex: sectionIndex, itemIndex: indexPath.row)
    }
}
