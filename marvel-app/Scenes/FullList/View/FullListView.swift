//
//  FullListView.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 12/01/23.
//

import UIKit

protocol FullListViewDelegateProtocol: AnyObject {
    func viewDidLoad()
    func scrolledForMoreItems(searchBarContent: String?)
    func searchButtonClicked(searchBarContent: String?)
    func backButtonTapped()
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
    
    private lazy var fullListSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barStyle = .black
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .marvelWhite
        searchBar.searchTextField.textColor = .marvelWhite
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        return searchBar
    }()
    
    private lazy var verticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cellSize = round((UIScreen.main.bounds.width - 50)/2)
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
    private var numberOfCells: Int = 9
    
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
        addSubviews(headerView, titleLabel, fullListSearchBar, verticalCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            
            fullListSearchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            fullListSearchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            fullListSearchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            
            verticalCollectionView.topAnchor.constraint(equalTo: fullListSearchBar.bottomAnchor, constant: 8.0),
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
            self?.fullListSearchBar.placeholder = model.searchBarPlaceholder
            self?.numberOfCells = model.numberOfCells
            self?.itemList = model.itemList
            self?.verticalCollectionView.reloadData()
        }
    }
    
    private func updateFilteredItems(searchBarContent: String?) {
        self.endEditing(true)
        itemList = []
        verticalCollectionView.reloadData()
        delegate?.searchButtonClicked(searchBarContent: searchBarContent)
    }
    
}

extension FullListView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < itemList.count {
            guard let cell = verticalCollectionView.dequeueReusableCell(
                withReuseIdentifier: ItemVerticalCollectionViewCell.identifier,
                for: indexPath
            ) as? ItemVerticalCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.updateView(with: itemList[indexPath.row])
            return cell
            
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LoadingCell.identifier,
                for: indexPath) as? LoadingCell else {
                return UICollectionViewCell()
            }
            
            cell.updateView(with: round((UIScreen.main.bounds.width - 50)/2))
            return cell
            
        }
        
    }
    
}

extension FullListView: HeaderViewClickDelegateProtocol {
    func didTapLeftButton() {
        delegate?.backButtonTapped()
    }
}

extension FullListView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        updateFilteredItems(searchBarContent: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            updateFilteredItems(searchBarContent: searchText)
        }
    }
}

extension FullListView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let positionY = verticalCollectionView.contentOffset.y
        let contentHeight = verticalCollectionView.contentSize.height
        if positionY > contentHeight - verticalCollectionView.frame.size.height {
            delegate?.scrolledForMoreItems(searchBarContent: fullListSearchBar.text)
        }
    }
}



