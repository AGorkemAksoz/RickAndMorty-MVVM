//
//  RMCollectionViewCell.swift
//  Rick&Morty-MVVM
//
//  Created by Ali Görkem Aksöz on 24.02.2023.
//

import UIKit

class RMCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCollectionViewCell"
    
    private let RMImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        imageView.backgroundColor = .brown
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(RMImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        RMImageView.frame = contentView.bounds
    }
}
