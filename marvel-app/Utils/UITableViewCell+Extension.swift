//
//  UITableViewCell+Extension.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 23/12/22.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return staticIdentifier
    }
    
    private static var staticIdentifier: String {
        return String(describing: self)
    }
}
