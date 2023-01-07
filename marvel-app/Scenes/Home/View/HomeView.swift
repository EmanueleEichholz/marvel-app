//
//  CharacterListView.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import UIKit

protocol HomeViewDelegateProtocol: AnyObject {
    func didSelectCharacter(at index: Int)
    func didSelectComic(at index: Int)
    func didSelectCreator(at index: Int)
    func didSelectEvent(at index: Int)
    func didSelectSerie(at index: Int)
}

final class HomeView: UIView {
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.updateView(with: HeaderViewModel(leftIcon: nil, logo: .marvelLogo, rightIcon: nil, iconColor: .white))
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
        tableView.register(HorizontalCollectionView.self, forCellReuseIdentifier: HorizontalCollectionView.identifier)
        tableView.register(ErrorCell.self, forCellReuseIdentifier: ErrorCell.identifier)
        return tableView
    }()
    
    private var characters: [ItemCardModel] = []
    private var comics: [ItemCardModel] = []
    private var creators: [ItemCardModel] = []
    private var events: [ItemCardModel] = []
    private var series: [ItemCardModel] = []
    private var stories: [ItemCardModel] = []
    
    weak var delegate: HomeViewDelegateProtocol?
    private let error: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func updateCharactersSection(with charactersInfo: [ItemCardModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.characters = charactersInfo
            self?.tableView.reloadSections([0], with: .none)
        }
    }
    
    func updateComicsSection(with comicsInfo: [ItemCardModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.comics = comicsInfo
            self?.tableView.reloadSections([1], with: .none)
        }
    }
    
    func updateCreatorsSection(with creatorsInfo: [ItemCardModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.creators = creatorsInfo
            self?.tableView.reloadSections([2], with: .none)
        }
    }
    
    func updateEventsSection(with eventsInfo: [ItemCardModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.events = eventsInfo
            self?.tableView.reloadSections([3], with: .none)
        }
    }
    
    func updateSeriesSection(with seriesInfo: [ItemCardModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.series = seriesInfo
            self?.tableView.reloadSections([4], with: .none)
        }
    }
    
    private func setupLayout() {
        backgroundColor = .marvelBlack
        addSubviews(headerView, tableView)
        
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
}

extension HomeView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ListTypeEnum.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let sectionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 22))
        sectionLabel.textColor = .marvelWhite
        sectionLabel.font = .systemFont(ofSize: 22.0, weight: .bold)
        sectionLabel.textAlignment = .left
        sectionLabel.numberOfLines = 0
        
        let section = ListTypeEnum(rawValue: section)
        switch section {
        case .characters:
            sectionLabel.text = "CHARACTERS"
        case .comics:
            sectionLabel.text = "COMICS"
        case .creators:
            sectionLabel.text = "CREATORS"
        case .events:
            sectionLabel.text = "EVENTS"
        case .series:
            sectionLabel.text = "SERIES"
        case .none:
            sectionLabel.text = "UNKNOW"
        }
        
        headerView.addSubview(sectionLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = ListTypeEnum(rawValue: indexPath.section)
        
        if !error.isEmpty {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ErrorCell.identifier,
                for: indexPath
            ) as? ErrorCell else {
                return UITableViewCell()
            }
            cell.updateView(text: "errrooooo maluco")
            return cell
        }
        
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HorizontalCollectionView.identifier,
            for: indexPath
        ) as? HorizontalCollectionView else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch section {
        case .characters, .none:
            cell.updateView(with: characters, sectionIndex: section?.rawValue)
        case .comics:
            cell.updateView(with: comics, sectionIndex: section?.rawValue)
        case .creators:
            cell.updateView(with: creators, sectionIndex: section?.rawValue)
        case .events:
            cell.updateView(with: events, sectionIndex: section?.rawValue)
        case .series:
            cell.updateView(with: series, sectionIndex: section?.rawValue)
        }
        return cell
    }
}

extension HomeView: HorizontalCollectionViewDelegate {
    func didSelectItem(sectionIndex: Int?, itemIndex: Int?) {
        guard let sectionIndex = sectionIndex,
              let itemIndex = itemIndex else { return }
        
        let section = ListTypeEnum(rawValue: sectionIndex)

        switch section {
        case .characters, .none:
            delegate?.didSelectCharacter(at: itemIndex)
        case .comics:
            delegate?.didSelectComic(at: itemIndex)
        case .creators:
            delegate?.didSelectCreator(at: itemIndex)
        case .events:
            delegate?.didSelectCreator(at: itemIndex)
        case .series:
            delegate?.didSelectSerie(at: itemIndex)
        }
    }
}
