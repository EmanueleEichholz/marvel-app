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
        view.updateView(with: HeaderViewModel(leftIcon: nil, logo: .marvelLogo, rightIcon: nil, iconColor: .white))
        view.delegate = self
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = true
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)
        return tableView
    }()
    
    weak var delegate: FullListViewDelegateProtocol?
    private var itemList: [ItemCardModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        setupAdditinalLayoutSettings()
        
        headerView.updateView(
            with: HeaderViewModel(
                leftIcon: UIImage(
                    systemName: "chevron.left"),
                logo: .marvelLogo,
                rightIcon: nil,
                iconColor: .marvelWhite
            )
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubviews() {
        addSubviews(headerView, tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8.0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
        ])
    }
    
    private func setupAdditinalLayoutSettings() {
        backgroundColor = .marvelBlack
    }
}

extension FullListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ItemTableViewCell.identifier,
            for: indexPath
        ) as? ItemTableViewCell else {
            return UITableViewCell()
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

