//
//  AlertViewController.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 11/01/23.
//

import UIKit

extension UIViewController {
    
    func showAlert(model: AlertModel, firstButtonAction: (() -> Void)?, secondButtonAction: (() -> Void)?) {
        
        DispatchQueue.main.async {
            
            let alert = UIAlertController(
                title: model.title,
                message: model.message,
                preferredStyle: .alert
            )
            
            alert.addAction(
                UIAlertAction(
                    title: model.firstButtonTitle,
                    style: UIAlertAction.Style.default,
                    handler: { action in
                        firstButtonAction?()
                    }))
            
            alert.addAction(
                UIAlertAction(
                    title: model.secondButtonTitle,
                    style: UIAlertAction.Style.default,
                    handler: { action in
                        secondButtonAction?()
                    }))
            
            
            if !alert.isBeingPresented {
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
}
