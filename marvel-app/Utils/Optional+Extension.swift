//
//  Optional+Extension.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 06/11/22.
//

import UIKit

extension Optional where Wrapped == UIImage {
    public var getSafeImage: UIImage {
        return self ?? UIImage()
    }
}
