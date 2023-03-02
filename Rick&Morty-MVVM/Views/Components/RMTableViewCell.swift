//
//  RMTableViewCell.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 1.03.2023.
//

import UIKit

class RMTableViewCell: UITableViewCell {
    
    static let identifier = "RMTableViewCellRMTableViewCell"
    
    private let characterPosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let characterStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(characterPosterImageView)
        contentView.addSubview(characterNameLabel)
        contentView.addSubview(characterStatusLabel)
        
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let characterPosterImageViewConstraints = [
            characterPosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            characterPosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            characterPosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            characterPosterImageView.widthAnchor.constraint(equalToConstant: 100),
            characterPosterImageView.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let characterNameLabelConstraints = [
            characterNameLabel.leadingAnchor.constraint(equalTo: characterPosterImageView.trailingAnchor, constant: 16),
            characterNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            characterNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
        ]
        
        let characterStatusLabelConstraints = [
            characterStatusLabel.leadingAnchor.constraint(equalTo: characterPosterImageView.trailingAnchor, constant: 16),
            characterStatusLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(characterPosterImageViewConstraints)
        NSLayoutConstraint.activate(characterNameLabelConstraints)
        NSLayoutConstraint.activate(characterStatusLabelConstraints)
        
    }
    
    public func configureCell(with model: CharacterItem) {
        
        guard let imageURL = URL(string: model.image ?? "") else { return }
        DispatchQueue.global().async { [weak self] in
             guard let imageData = try? Data(contentsOf: imageURL) else {
                 return
             }
             let image = UIImage(data: imageData)
             DispatchQueue.main.async {
                 self?.characterPosterImageView.image = image
             }
         }
        
        characterNameLabel.text = model.name
        characterStatusLabel.text = model.status
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
