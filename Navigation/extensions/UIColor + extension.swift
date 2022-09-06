//
//  UIColor + extension.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 01.08.2022.
//

import Foundation
import UIKit

extension UIColor{
    static var appTintColor: UIColor = {
        if #available(iOS 13, *){
            return UIColor{ (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark{
                    return UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
                } else {
                    return UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.0)
                }
            }
        } else {
            return UIColor.systemBlue
        }
    }()
    
    static var appTextColor: UIColor = {
        if #available(iOS 13, *){
            return UIColor{ (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark{
                    return UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
                } else {
                    return UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
                }
            }
        } else {
            return UIColor.systemBlue
        }
    }()
}
