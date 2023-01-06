//
//  UIView+Extension.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 02/11/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
        }
    }
    
    func removeAllSubviews() {
        subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func setVerticalLinearGradient(startPoint: Double, endPoint: Double) {
        DispatchQueue.main.async {
            let gradient = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = [UIColor.marvelDarkGray.cgColor, UIColor.black.withAlphaComponent(0.0).cgColor]
            gradient.startPoint = CGPoint(x: 0.0, y: startPoint)
            gradient.endPoint = CGPoint(x: 0.0, y: endPoint)
            self.layer.insertSublayer(gradient, at: 0)
        }
    }
}
