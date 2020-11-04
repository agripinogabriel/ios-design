//
//  CircularSeletion.swift
//  Add Pizza Interaction
//
//  Created by Agripino Gabriel on 27/10/20.
//

import UIKit

protocol CircularSelectionDataSource {
    func view(for index: Int) -> UIView
}

protocol CircularSelectionDelegate {
    func didSelect(index: Int)
    func highlight(view: UIView)
    func unhighlight(view: UIView)
}

class CircularSeletion: UIView {
    
    private var circularView: UIView!
    
    private let dataSource: CircularSelectionDataSource
    private let delegate: CircularSelectionDelegate
    
    private let radius: CGFloat
    
    private var currentIndex =  1 {
        willSet {
            let view = circularView.viewWithTag(currentIndex)!
            delegate.unhighlight(view: view)
        }
    }
        
    required init(center: CGPoint, radius: CGFloat, dataSource: CircularSelectionDataSource, delegate: CircularSelectionDelegate) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.radius = radius
        super.init(frame: .zero)
        bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    func showTopSelectorMarker() {        
        
        let shapeLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: circularView.center, radius: radius, startAngle: -1.1 * CGFloat.pi / 2, endAngle: -0.9 * CGFloat.pi / 2, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 1
        layer.addSublayer(shapeLayer)
    }
    
    func showBottomSelectorMark() {
        let view = UIView()
        view.backgroundColor = .red
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.topAnchor.constraint(equalTo: circularView.topAnchor, constant: 55).isActive = true
        view.centerXAnchor.constraint(equalTo: circularView.centerXAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: 8).isActive = true
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handlePizzaSizeTap(sender: UITapGestureRecognizer) {        
        
        guard let view = sender.view else { return }
        
        let clicableBounds = bounds.width / 3
        
        if sender.location(in: self).x <= clicableBounds || sender.location(in: self).x >= 2*clicableBounds {
            let angle = CGFloat(view.tag - 1) * -40.0 * CGFloat.pi / 180
            rotate(angle)
            delegate.didSelect(index: view.tag - 1)
            delegate.highlight(view: view)
            currentIndex = view.tag
        }
        
    }
    
    private func rotate(_ angle: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.circularView.transform = CGAffineTransform.init(rotationAngle: angle)
        }
    }
}

extension CircularSeletion: CodedView {
    
    func setupViews() {
        
        circularView = UIView()
        circularView.isUserInteractionEnabled = true
        
        circularView.layer.cornerRadius = frame.height / 2
        circularView.backgroundColor = .white
        
        for index in 0...8 {
            
            let v = UIView()
            v.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
            circularView.addSubview(v)
            v.center = CGPoint(x: bounds.width / 2 - 30, y: 0)
            
            let view = dataSource.view(for: index)
            view.tag = index + 1
            view.sizeToFit()
            view.center = v.center
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePizzaSizeTap)))
                        
            circularView.addSubview(view)
                        
            let angle = CGFloat(index) * 40 * CGFloat.pi / 180 - 90 * CGFloat.pi / 180
            let x: CGFloat = v.center.x * cos(angle) - 0 * sin(angle) + 30
            let y: CGFloat = v.center.x * sin(angle) + 0 * cos(angle) + bounds.width / 2
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: x, y: y)
            transform = transform.rotated(by: angle)
            
            v.transform = transform
            
            let textAngle = CGFloat(index) * 40 * CGFloat.pi / 180
            var transform1 = CGAffineTransform.identity
            transform1 = transform1.translatedBy(x: x, y: y)
            transform1 = transform1.rotated(by: textAngle)
            view.transform = transform1
        }
        
        delegate.highlight(view: circularView.viewWithTag(1)!)
    }
    
    func setupHierarchy() {
        addSubview(circularView)
    }
    
    func setupLayout() {
        circularView.frame = bounds
    }
}
