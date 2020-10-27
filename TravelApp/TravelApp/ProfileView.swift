//
//  ProfileView.swift
//  TravelApp
//
//  Created by Agripino Gabriel on 26/10/20.
//

import UIKit

class ProfileView: UIView {
    
    private var contentView: UIView!
    private var imageView: UIImageView!
    
    var image: UIImage? {
        set {
            imageView.image = newValue
        }
        get {
            imageView.image
        }
    }
    
    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileView: CodedView {
    
    func setupViews() {
        contentView = UIView()
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 25
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        
        [
            contentView,
            imageView
        ]
        .forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupHierarchy() {
        addSubview(contentView)
        contentView.addSubview(imageView)
    }
    
    func setupLayout() {
        
        [
            contentView.heightAnchor.constraint(equalToConstant: 50),
            contentView.widthAnchor.constraint(equalToConstant: 50),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ]
        .forEach {
            $0.isActive = true
        }
    }
}
