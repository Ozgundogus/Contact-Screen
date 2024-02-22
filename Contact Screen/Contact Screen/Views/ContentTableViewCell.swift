//
//  ContentCollectionViewCell.swift
//  Contact Screen
//
//  Created by Ozgun Dogus on 10.02.2024.
//

import UIKit
import Kingfisher


class ContentTableViewCell: UITableViewCell {
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    let cellArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellViews() {
        addSubview(cellImageView)
        addSubview(cellTitleLabel)
        addSubview(cellArrowButton)
        
        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: 80),
            cellImageView.heightAnchor.constraint(equalToConstant: 40),
            
            cellTitleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 20),
            cellTitleLabel.trailingAnchor.constraint(equalTo: cellArrowButton.leadingAnchor, constant: -20),
            cellTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            cellArrowButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cellArrowButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellArrowButton.heightAnchor.constraint(equalToConstant: 40),
            cellArrowButton.widthAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    func configure(with article: Article) {
        cellTitleLabel.text = article.title
        if let urlString = article.urlToImage, let url = URL(string: urlString) {
            cellImageView.kf.setImage(with: url) // placeholder image 
        } else {
            cellImageView.image = nil
        }
    }

}
