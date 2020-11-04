//
//  ViewController.swift
//  Add Pizza Interaction
//
//  Created by Agripino Gabriel on 27/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    private let sizes = ["M", "L", "S"]
    private let zoomFactor: [CGFloat] = [1, 1.4, 0.6]
    
    private var imageView : UIImageView!
    private var circularViewContainer: UIView!
    private var circularView: CircularSeletion!
    private var orderButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    private func handlePizzaTap(zoomScale: CGFloat) {
        
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: zoomScale * CGFloat.pi / 2)
        transform = transform.scaledBy(x: zoomScale, y: zoomScale)
        
        UIView.animate(withDuration: 0.6) {
            self.imageView.transform = transform
        }
    }
    
    
    func addLabel(label: UILabel, to view: UIView) {
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    @objc private func animateButton() {
        UIView.animate(withDuration: 1.5) {
            self.orderButton.alpha = 0
            self.orderButton.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }
    }
    
    @objc private func reverseAnimateButton() {
        UIView.animate(withDuration: 1.5) {
            self.orderButton.alpha = 1
            self.orderButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

extension ViewController: CircularSelectionDataSource {
    
    func view(for index: Int) -> UIView {
        let position = index % 3
        
        let label = UILabel()
        label.text = sizes[position]
        label.textColor = .black
        label.font = .systemFont(ofSize: 36, weight: .heavy)
        return label
    }
}

extension ViewController: CircularSelectionDelegate {
    
    func highlight(view: UIView) {
        guard let label = view as? UILabel else { return }
        label.textColor = .red
    }
    
    func unhighlight(view: UIView) {
        guard let label = view as? UILabel else { return }
        label.textColor = .black
    }
    
    
    func didSelect(index: Int) {
        let position = index % 3
        handlePizzaTap(zoomScale: zoomFactor[position])
    }
}

extension ViewController: CodedView {
    
    func setupViews() {
        
        view.backgroundColor = .white
        
        navigationItem.title = "Pepperoni Pizza"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "pizza-box"), style: .plain, target: self, action: #selector(reverseAnimateButton))
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 250.0/255.0, green: 57.0/255.0, blue: 70.0/255.0, alpha: 1)
        
        imageView = UIImageView(image: #imageLiteral(resourceName: "pepperoni-pizza"))
        imageView.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.isUserInteractionEnabled = true
        
        circularView = CircularSeletion(center: view.center, radius: 250, dataSource: self, delegate: self)
        circularView.showTopSelectorMarker()
        circularView.layer.shadowColor = UIColor.black.cgColor
        circularView.layer.shadowOpacity = 0.2
        circularView.layer.shadowOffset = .zero
        circularView.layer.shadowRadius = 10
        
        circularViewContainer = UIView()
        circularViewContainer.layer.masksToBounds = true
        circularViewContainer.addSubview(circularView)
        
        orderButton = UIButton()
        orderButton.backgroundColor = UIColor(red: 250.0/255.0, green: 57.0/255.0, blue: 70.0/255.0, alpha: 1)
        orderButton.setTitle("ORDER NOW!", for: .normal)
        orderButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 32, bottom: 12, right: 32)
        orderButton.layer.masksToBounds = true
        orderButton.layer.cornerRadius = 24
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.addTarget(self, action: #selector(animateButton), for: .touchUpInside)
        
        [
            imageView,
            circularViewContainer,
            orderButton,
        ]
        .forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupHierarchy() {
        
        [
            imageView,
            circularViewContainer,
            orderButton,
        ]
        .forEach {
            view.addSubview($0)
        }
    }
    
    func setupLayout() {
        
        [
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            
            circularViewContainer.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            circularViewContainer.heightAnchor.constraint(equalToConstant: 180),
            circularViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            circularViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            orderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ]
        .forEach {
            $0.isActive = true
        }
        
        circularView.center = CGPoint(x: view.center.x, y: 280)
    }
}


