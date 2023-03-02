//
//  SearchViewModel.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 2.03.2023.
//

import Foundation


protocol SearchViewModelInterface {
    var view: SearchViewControllerInterface? {get set}
    
    func viewDidLoad()
}

final class SearchViewModel {
    weak var view: SearchViewControllerInterface?
}

extension SearchViewModel: SearchViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureSearchController()
        view?.configureTitle()
        view?.configureConstraints()
    }
    
    
}

