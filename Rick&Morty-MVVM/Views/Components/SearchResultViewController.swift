//
//  SearchResultViewController.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 25.02.2023.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var characters = [Results]()
    
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

        view.backgroundColor = .systemRed
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCollectionViewCell.identifier, for: indexPath) as? RMCollectionViewCell
        cell?.setup(characters[indexPath.item].image)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
               RMService.shared.getCharacter(id: characters[indexPath.item].id ?? 0) { [weak self] item, error in
            DispatchQueue.main.async {
                let vc = UINavigationController(rootViewController: DetailScreenViewController(character: self?.characters[indexPath.item]))
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            }
        }

    }
    
}
