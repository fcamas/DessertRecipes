//
//  SearchResultCell.swift
//  FetchChallenge_FredyCamas_Spring2024
//
//  Created by Fredy Camas on 1/3/24.
//

import UIKit

// UICollectionViewCell subclass for displaying meal information.
class MealCollectionCell: UICollectionViewCell {

    // Static property for the cell identifier.
    static let id = "MealCell"

    // MARK: - UI Elements

    // UIImageView for displaying meal images.
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // UILabel for displaying the name of the meal.
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // UILabel for displaying an ID or description of the meal.
    let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // UIButton for displaying  heart as Favorite
    let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers

    // Designated initializer for the cell.
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadConstraints()
    }

    // Required initializer when creating the cell from a storyboard or nib file.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Method to set up layout constraints for UI elements within the cell.
    private func loadConstraints() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(heartButton)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
         
            

            heartButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant:  8),
            heartButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
          
            
            idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }

    
}

