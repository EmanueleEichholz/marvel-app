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
    
    func setVerticalLinearGradient(initialColor: UIColor, startPoint: Double, endPoint: Double) {
        DispatchQueue.main.async {
            let gradient = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = [initialColor.cgColor, UIColor.black.withAlphaComponent(0.0).cgColor]
            gradient.startPoint = CGPoint(x: 0.0, y: startPoint)
            gradient.endPoint = CGPoint(x: 0.0, y: endPoint)
            self.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    func startShimmering() {
        let lightColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor
        let darkColor = UIColor.black.cgColor
        let colorArray: [CGColor] = [lightColor, darkColor, lightColor]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray
        gradientLayer.frame = CGRect(x: -bounds.size.width, y: 0, width: 3 * bounds.size.width, height: bounds.height)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0.4, 0.45, 0.5]
        layer.mask = gradientLayer
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1.5
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animation]
        animationGroup.duration = 1.5
        animationGroup.repeatCount = HUGE
        
        gradientLayer.add(animationGroup, forKey: "shimmer")
    }
    
}

enum Direction: Int {
  case topToBottom = 0
  case bottomToTop
  case leftToRight
  case rightToLeft
}
