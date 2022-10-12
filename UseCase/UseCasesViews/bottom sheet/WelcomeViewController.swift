//
//  ViewController.swift
//  UseCase
//
//  Created by Rodrigo Souza on 03/10/22.
//

import UIKit


class WelcomeViewController: BottomSheetContainerViewController
<HelloViewController, MyCustomViewController> {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}
