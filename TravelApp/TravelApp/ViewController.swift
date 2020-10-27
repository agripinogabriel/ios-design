//
//  ViewController.swift
//  TravelApp
//
//  Created by Agripino Gabriel on 25/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    private var currentCell = 0
    private let collectionMargin = CGFloat(25)
    private let itemSpacing = CGFloat(15)
    private var itemWidth = CGFloat(0)
    private let itemHeight = CGFloat(416)
    
    private var effectView: UIVisualEffectView!
    private var imageView: UIImageView!
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
}

extension ViewController: CodedView {
    
    func setupViews() {
        view.backgroundColor = .white
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        itemWidth =  UIScreen.main.bounds.width - collectionMargin * 2.0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = itemSpacing
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.backgroundColor = .clear
        collectionView.register(CardView.self, forCellWithReuseIdentifier: "CardView")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: locations[0].imageName)!        
        
        let effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        effectView = UIVisualEffectView(effect: effect)
        effectView.alpha = 0.6
        
        [
            imageView,
            effectView,
            collectionView,
        ]
        .forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    func setupHierarchy() {
        [
            imageView,
            effectView,
            collectionView,
        ]
        .forEach {
            view.addSubview($0)
        }
    }
    
    func setupLayout() {
        
        imageView.pin(to: view)
        effectView.pin(to: view)
        
        [
            collectionView.heightAnchor.constraint(equalToConstant: 416),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        .forEach {
            $0.isActive = true
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardView = collectionView.dequeueReusableCell(withReuseIdentifier: "CardView", for: indexPath) as! CardView
        cardView.image = UIImage(named: locations[indexPath.row].imageName)
        cardView.tripDate = locations[indexPath.row].date
        cardView.location = locations[indexPath.row].name
        cardView.imageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        return cardView
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = Float(itemWidth + itemSpacing)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView.contentSize.width)
        var newPage = Float(self.currentCell)

        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.currentCell + 1 : self.currentCell - 1)
            if newPage < 0 {
                newPage = 0
            }
            if (newPage > contentWidth / pageWidth) {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        self.currentCell = Int(newPage)
        let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
        
        let index = Int(targetContentOffset.pointee.x / (UIScreen.main.bounds.width - collectionMargin * 2.0))
        let indexPath = IndexPath(row: index, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as? CardView
        if indexPath.row >= 0 && indexPath.row < locations.count {
            UIView.animate(withDuration: 0.5) {
                self.imageView.image = UIImage(named: locations[indexPath.row].imageName)
            }
        }
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeCubic, animations: {
            cell?.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
        let previousIndex = index - 1
        let nextIndex = index + 1
        if previousIndex >= 0 {
            let indexPath = IndexPath(row: previousIndex, section: 0)
            let cell = collectionView.cellForItem(at: indexPath) as? CardView
            UIView.animate(withDuration: 0.5) {
                cell?.imageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
        }
        if nextIndex < locations.count {
            let indexPath = IndexPath(row: nextIndex, section: 0)
            let cell = collectionView.cellForItem(at: indexPath) as? CardView
            UIView.animate(withDuration: 0.5) {
                cell?.imageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }
        }
    }
}

