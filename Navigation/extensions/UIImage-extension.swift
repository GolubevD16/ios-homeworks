//
//  UIImage-extension.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 09.11.2021.
//

import Foundation
import UIKit

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
