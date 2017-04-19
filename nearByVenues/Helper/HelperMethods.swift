//
//  HelperMethods.swift
//  nearByVenues
//
//  Created by Jitendra Gaur on 3/18/17.
//  Copyright © 2017 Jitendra Gaur. All rights reserved.
//

import UIKit

struct HelperMethods {
    
    private static var loaderView: loaderView!
    
    static let keyWindow = (UIApplication.shared.delegate as? AppDelegate)?.window
    
    static func showActivityIndicatory(label: String) {
        loaderView = UINib(nibName: "loaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? loaderView
        loaderView.frame = UIScreen.main.bounds
        loaderView.loaderLabel.text = label
        HelperMethods.keyWindow?.addSubview(loaderView)
    }
    
    static func hideActivityIndicatory() {
        loaderView.removeFromSuperview()
    }
}
