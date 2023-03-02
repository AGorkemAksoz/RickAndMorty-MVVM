//
//  FavoritesViewController.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 23.02.2023.
//

import UIKit

protocol FavoritesViewControllerInterface {
    func configureVC()
    func configureTitle()
    func configureTableView()
    func configureTableViewFrame()
    func reloadTable()
}

class FavoritesViewController: UIViewController {
    
    private let favoritesViewModel = FavoritesViewModel()
    
    private let characterTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RMTableViewCell.self, forCellReuseIdentifier: RMTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesViewModel.view = self
        favoritesViewModel.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureTableViewFrame()
    }
    
    }

extension FavoritesViewController: FavoritesViewControllerInterface {
    func configureTableViewFrame() {
        characterTableView.frame = view.bounds
    }
    
    func configureVC() {
        view.backgroundColor = .systemTeal
    }
    
    func configureTitle() {
        title = "Favorites"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    func configureTableView() {
        view.addSubview(characterTableView)
        
        characterTableView.delegate = self
        characterTableView.dataSource = self
    }
    
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.characterTableView.reloadData()
        }
    }

    
}
    
    extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            favoritesViewModel.characters.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard  let cell = tableView.dequeueReusableCell(withIdentifier: RMTableViewCell.identifier, for: indexPath) as? RMTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(with: favoritesViewModel.characters[indexPath.row])
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            120
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            switch editingStyle {
            case .delete:
                DataPersistenceManager.shared.deletingCharacter(with: favoritesViewModel.characters[indexPath.item]) { [weak self] result in
                    switch result {
                    case .success():
                        print("Deleted from the database")
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                    self?.favoritesViewModel.characters.remove(at: indexPath.item)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            default:
                break
            }
        }
        
    }
