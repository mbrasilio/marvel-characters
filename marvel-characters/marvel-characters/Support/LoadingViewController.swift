//
//  LoadingViewController.swift
//  marvel-characters
//
//  Created by Matheus Brasilio on 29/01/21.
//  Copyright © 2021 Matheus Brasilio. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    // MARK: - Attributes
    let loadingActivityIndicator = UIActivityIndicatorView()
    let blurEffectView = UIVisualEffectView()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.view.addLoading(loadingActivityIndicator, blurEffectView)
    }
}
