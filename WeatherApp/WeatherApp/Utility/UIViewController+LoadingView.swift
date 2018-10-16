//
//  UIViewController+LoadingView.swift
//  WeatherApp
//
//  Created by Niloy Chakraborty on 16/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class func displayLoadingIndicator(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }

        return spinnerView
    }

    class func removeLoadingIndicator(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
