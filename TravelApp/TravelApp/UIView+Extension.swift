//
//  UIView+Extension.swift
//  TravelApp
//
//  Created by Agripino Gabriel on 26/10/20.
//

import UIKit

extension UIView {
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
}

class Box<T> {
    typealias Listener = (_: T) -> Void
    
    var listener: Listener?
    
    var value: T {
        didSet {
            self.listener?(self.value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        self.listener?(self.value)
    }
}
