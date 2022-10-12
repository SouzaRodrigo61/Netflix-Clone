//
//  MyCustomViewController.swift
//  UseCase
//
//  Created by Rodrigo Souza on 03/10/22.
//

import UIKit

class MyCustomViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.view.layer.shadowColor = UIColor.black.cgColor
        self.view.layer.shadowOffset = .init(width: 0, height: -2)
        self.view.layer.shadowRadius = 10
        self.view.layer.shadowOpacity = 0.2
    }
}
