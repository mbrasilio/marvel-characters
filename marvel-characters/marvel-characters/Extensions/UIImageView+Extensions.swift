//
//  UIImageView+Extensions.swift
//  marvel-characters
//
//  Created by Matheus Brasilio on 30/01/21.
//  Copyright © 2021 Matheus Brasilio. All rights reserved.
//

import UIKit

extension UIImageView {
    public func downloadImageFrom(link: String?) {
        let indicator = UIActivityIndicatorView()
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        self.addLoading(indicator, blurEffectView)
        if let imageLink = link {
            URLSession.shared.dataTask(with: NSURL(string: imageLink)! as URL, completionHandler: { (data, response, error) -> Void in
                DispatchQueue.main.async {
                    if let data = data { self.image = UIImage(data: data) }
                    indicator.removeFromSuperview()
                    blurEffectView.removeFromSuperview()
                }
            }).resume()
        }
    }
}
