//
//  DetailScreenViewController.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 24.02.2023.
//

import UIKit

class DetailScreenViewController: UIViewController {
    
    let character: Results?
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    init(character: Results?) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(characterImageView)
        view.addSubview(nameLabel)
        view.addSubview(statusLabel)
        view.addSubview(speciesLabel)
        view.addSubview(genderLabel)
        view.addSubview(placeLabel)
        
        configureConstraints()
        configureCharacterImageView()
        configureNameLabel()
        configureStatusLabel()
        configureSpeciesLabel()
        configureGenderLabel()
        configurePlaceLabel()
    }
    private func configurePlaceLabel() {
        placeLabel.text = "From: \(character?.origin?.name ?? "error")"
    }
    
    private func configureGenderLabel() {
        genderLabel.text = character?.gender
    }
    
    private func configureSpeciesLabel() {
        speciesLabel.text = character?.species
    }
    
    private func configureStatusLabel() {
        statusLabel.text = character?.status
    }
    
    private func configureNameLabel() {
        nameLabel.text = character?.name
    }
    
    private func configureCharacterImageView() {
        guard let url = URL(string: character?.image ?? "") else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: url) else {
                return
            }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self?.characterImageView.image = image
            }
        }
    }
    
    private func configureConstraints() {
        let characterImageViewConstraints = [
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 300),
            characterImageView.widthAnchor.constraint(equalToConstant: 260)
        ]
        
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: characterImageView.centerXAnchor)
        ]
        
        let statusLabelConstraints = [
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            statusLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor)
        ]
        
        let speciesLabelConstraints = [
            speciesLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            speciesLabel.leadingAnchor.constraint(equalTo: statusLabel.centerXAnchor, constant: -65),
        ]
        
        let genderLabelConstraints = [
            genderLabel.leadingAnchor.constraint(equalTo: speciesLabel.trailingAnchor, constant: 12),
            genderLabel.topAnchor.constraint(equalTo: speciesLabel.topAnchor)
        ]
        
        let placeLabelConstraints = [
            placeLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20),
            placeLabel.centerXAnchor.constraint(equalTo: statusLabel.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(characterImageViewConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(statusLabelConstraints)
        NSLayoutConstraint.activate(speciesLabelConstraints)
        NSLayoutConstraint.activate(genderLabelConstraints)
        NSLayoutConstraint.activate(placeLabelConstraints)
    }
    
}
