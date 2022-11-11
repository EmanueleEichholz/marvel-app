//
//  UIImage+Extension.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 06/11/22.
//

import UIKit

extension UIImage {
    public static let marvelLogo: UIImage = UIImage(named: "marvel-logo").getSafeImage
    public static let whiteBackIcon: UIImage = UIImage(systemName: "chevron.backward").getSafeImage
}
