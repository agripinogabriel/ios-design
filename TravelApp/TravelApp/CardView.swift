//
//  CardView.swift
//  TravelApp
//
//  Created by Agripino Gabriel on 25/10/20.
//

import UIKit

class CardView: UICollectionViewCell {
    
    private var imageContainer: UIView!
    private(set) var imageView: UIImageView!
    private var daysBeforeDeparture: UILabel!
    private var travelDate: UILabel!
    private var locationLabel: UILabel!
    private var frontProvileView: ProfileView!
    private var backProvileView: ProfileView!
    private var overlayCard: UIView!
    
    var image: UIImage? {
        set {
            imageView.image = newValue
        }
        get {
            imageView.image
        }
    }
    
    var tripDate: String? {
        set {
            travelDate.text = newValue
        }
        get {
            travelDate.text
        }
    }
    
    var location: String? {
        set {
            locationLabel.text = newValue
        }
        get {
            locationLabel.text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardView: CodedView {
    
    func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        overlayCard = UIView()
        overlayCard.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        imageContainer = UIView()
        imageContainer.layer.masksToBounds = true
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        travelDate = UILabel()
        travelDate.font = .boldSystemFont(ofSize: 16)
        travelDate.textColor = .white
        
        locationLabel = UILabel()
        locationLabel.font = .boldSystemFont(ofSize: 48)
        locationLabel.textColor = .white
        locationLabel.numberOfLines = 0
        
        daysBeforeDeparture = UILabel()
        daysBeforeDeparture.font = .boldSystemFont(ofSize: 16)
        daysBeforeDeparture.textColor = .black
        daysBeforeDeparture.text = "4 days before departure"
        
        frontProvileView = ProfileView()
        frontProvileView.image = #imageLiteral(resourceName: "profile")
        
        backProvileView = ProfileView()
        backProvileView.image = #imageLiteral(resourceName: "profile")
        
        [
            imageView,
            daysBeforeDeparture,
            travelDate,
            locationLabel,
            frontProvileView,
            backProvileView,
            overlayCard,
            imageContainer,
        ]
        .forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupHierarchy() {
        
        imageContainer.addSubview(imageView)
        [
            imageContainer,
            overlayCard,
            daysBeforeDeparture,
            travelDate,
            locationLabel,
            backProvileView,
            frontProvileView,
        ]
        .forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupLayout() {
        
        [
            imageContainer.heightAnchor.constraint(equalToConstant: 350),
            imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            daysBeforeDeparture.centerYAnchor.constraint(equalTo: backProvileView.centerYAnchor),
            daysBeforeDeparture.trailingAnchor.constraint(equalTo: backProvileView.leadingAnchor, constant: -16),
            daysBeforeDeparture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            backProvileView.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 8),
            backProvileView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backProvileView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            frontProvileView.centerYAnchor.constraint(equalTo: backProvileView.centerYAnchor),
            frontProvileView.trailingAnchor.constraint(equalTo: backProvileView.leadingAnchor, constant: 24),
            
            travelDate.bottomAnchor.constraint(equalTo: imageContainer .bottomAnchor, constant: -12),
            travelDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            travelDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            locationLabel.bottomAnchor.constraint(equalTo: travelDate.topAnchor, constant: -12),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ]
        .forEach {
            $0.isActive = true
        }
        
        imageView.pin(to: imageContainer)
        overlayCard.pin(to: imageView)
    }
}
