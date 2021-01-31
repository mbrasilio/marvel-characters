//
//  UIViewController+Extensions.swift
//  marvel-characters
//
//  Created by Matheus Brasilio on 29/01/21.
//  Copyright © 2021 Matheus Brasilio. All rights reserved.
//

import UIKit

extension UIViewController {
    public func presentAlertDialog(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func presentLoading() {
        let vc = LoadingViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    public func removeLoading() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

