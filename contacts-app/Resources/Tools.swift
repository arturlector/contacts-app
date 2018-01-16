//
//  Tools.swift
//  contacts-app
//
//  Created by Arthur on 15/01/2018.
//  Copyright © 2018 stoicdev. All rights reserved.
//

import UIKit

extension UIView {
    var parentController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
