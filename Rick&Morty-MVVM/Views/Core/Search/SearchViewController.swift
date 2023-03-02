//
//  SearchViewController.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 23.02.2023.
//

import UIKit

protocol SearchViewControllerInterface: AnyObject {
    func configureVC()
    func configureSearchController()
    func configureTitle()
    func configureConstraints()
}

class SearchViewController: UIViewController {
    
    private let searchViewModel = SearchViewModel()
    
    private let warningLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You did not search for any Rick and Morty Chracter"
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let magnifyingGlassesEmoji: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    
    private let searchController: UISearchController = {
       let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for a Rick and Morty Character"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchViewModel.view = self
        searchViewModel.viewDidLoad()
        
    }
    
}

extension SearchViewController: SearchViewControllerInterface {
    func configureConstraints() {
        let magnifyingGlassesEmojiConstraints = [
            magnifyingGlassesEmoji.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            magnifyingGlassesEmoji.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            magnifyingGlassesEmoji.heightAnchor.constraint(equalToConstant: 120),
            magnifyingGlassesEmoji.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let warningLabelConstraints = [
            warningLabel.topAnchor.constraint(equalTo: magnifyingGlassesEmoji.bottomAnchor, constant: 20),
            warningLabel.centerXAnchor.constraint(equalTo: magnifyingGlassesEmoji.centerXAnchor),
            warningLabel.widthAnchor.constraint(equalToConstant: view.layer.bounds.width - 100)
        ]
        
        NSLayoutConstraint.activate(magnifyingGlassesEmojiConstraints)
        NSLayoutConstraint.activate(warningLabelConstraints)
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        view.addSubview(magnifyingGlassesEmoji)
        view.addSubview(warningLabel)

    }
    
    func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    func configureTitle() {
        title = "Search"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 2,
              let resultController = searchController.searchResultsController as? SearchResultViewController else { return }

        
        RMService.shared.getCharacterByName(query: query) { response, error in
            if let error = error {
                print(error)
            }
                resultController.characters = response ?? []
                resultController.reloadView()
        }
    }
}



