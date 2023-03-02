//
//  HomeViewModel.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 2.03.2023.
//

import Foundation

protocol HomeViewModelInterface {
    
    var view: HomeViewControllerInterface? {get set}
    
    func viewDidLoad()
    func getData()
}

final class HomeViewModel {
    weak var view: HomeViewControllerInterface?
    var characters = [Results]()
}

extension HomeViewModel: HomeViewModelInterface {

    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
        getData()
    }
    
    func getData() {
        RMService.shared.getCharacters { [weak self] result, error in
            self?.characters = result!
            self?.view?.reloadView()
        }
    }
    
}
