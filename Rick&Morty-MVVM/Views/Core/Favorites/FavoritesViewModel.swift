//
//  HomeViewViewModel.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 2.03.2023.
//

import Foundation

protocol FavoritesViewModelInterface {
    var view: FavoritesViewControllerInterface? {get set}
    
    func viewDidLoad()
    func fetchData()
    func addObserver()
}

final class FavoritesViewModel {
    var view: FavoritesViewControllerInterface?
    var characters: [CharacterItem] = []
}

extension FavoritesViewModel: FavoritesViewModelInterface {

    
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureTitle()
        view?.configureTableView()
        addObserver()
        fetchData()
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil) { _ in
            self.fetchData()
        }
    }
    func fetchData() {
        DataPersistenceManager.shared.fetchingCharacterFromDatabase { [weak self] result in
            switch result {
            case .success(let items):
                self?.characters = items
                self?.view?.reloadTable()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
