//
//  CharacterListView.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import UIKit

final class HomeView: UIView {
    
    let upperCharacterList = [CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                              CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                              CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                              CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                              CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                              CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                              CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                              CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark")]
    
    let bottomCharacterList = [CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark"),
                               CharacterViewModel(name: "Deadpool", image: "deadpool-question-mark")]
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.updateView(with: HeaderViewModel(leftIcon: nil, logo: .marvelLogo, rightIcon: nil, iconColor: .white))
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .marvelWhite
        label.font = .systemFont(ofSize: 20.0, weight: .heavy)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DESTAQUE"
        return label
    }()
    
    private lazy var upperCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cellSize = (UIScreen.main.bounds.width - 48)/2.5
        layout.estimatedItemSize = CGSize(width: 100.0, height: 100.0)
        layout.minimumLineSpacing = 16.0
        layout.minimumInteritemSpacing = 16.0
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.backgroundColor = .clear
        return collection
    }()
    
    private lazy var secondTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .marvelWhite
        label.font = .systemFont(ofSize: 20.0, weight: .heavy)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "LISTA"
        return label
    }()
    
    private lazy var bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cellSize = (UIScreen.main.bounds.width - 65)/3
        layout.estimatedItemSize = CGSize(width: cellSize, height: cellSize)
        layout.minimumLineSpacing = 16.0
        layout.minimumInteritemSpacing = 16.0
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.showsVerticalScrollIndicator = true
        collection.backgroundColor = .clear
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubviews(headerView, titleLabel, upperCollectionView, secondTitleLabel, bottomCollectionView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),

            upperCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            upperCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            upperCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            upperCollectionView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48)/2.5),
            
            secondTitleLabel.topAnchor.constraint(equalTo: upperCollectionView.bottomAnchor, constant: 32.0),
            secondTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            secondTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            
            bottomCollectionView.topAnchor.constraint(equalTo: secondTitleLabel.bottomAnchor, constant: 8.0),
            bottomCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            bottomCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            bottomCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16.0)
            
        ])
    }
}

extension HomeView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicou para abrir na posição \(indexPath.row)")
    }
    
}

extension HomeView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == upperCollectionView {
            return upperCharacterList.count
        } else {
            return bottomCharacterList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
            return UICollectionViewCell()
        }
        
        if collectionView == upperCollectionView {
            cell.setupUpperCollectionCell(with: upperCharacterList[indexPath.row])
            return cell
        } else {
            cell.setupBottomCollectionCell(with: bottomCharacterList[indexPath.row])
            return cell
        }
    }
    
}

extension HomeView: HeaderViewClickDelegateProtocol {
    func didTapLeftButton() {
        print("clicou pra fechar")
    }
}
