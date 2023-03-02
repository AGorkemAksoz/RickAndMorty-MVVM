//
//  HomeViewController.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 23.02.2023.
//

import UIKit

protocol HomeViewControllerInterface: AnyObject {
    func configureVC()
    func reloadView()
    func configureCollectinViewFrame()
    func configureCollectionView()
}

class HomeViewController: UIViewController {
    
    private let homeViewModel = HomeViewModel()

    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 230)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMCollectionViewCell.self, forCellWithReuseIdentifier: RMCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewModel.view = self
        homeViewModel.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectinViewFrame()
    }
    
}

extension HomeViewController: HomeViewControllerInterface {
    func configureCollectionView() {
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func configureVC() {
        view.backgroundColor = .systemCyan
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        title = "Home"
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func configureCollectinViewFrame() {
        collectionView.frame = view.bounds
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeViewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCollectionViewCell.identifier, for: indexPath) as? RMCollectionViewCell
        cell?.setup(homeViewModel.characters[indexPath.item].image)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        RMService.shared.getCharacter(id: homeViewModel.characters[indexPath.item].id ?? 21) { [weak self] item, error in
            DispatchQueue.main.async {
                let vc = DetailScreenViewController(character: self?.homeViewModel.characters[indexPath.item])
                vc.modalPresentationStyle = .fullScreen
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}


