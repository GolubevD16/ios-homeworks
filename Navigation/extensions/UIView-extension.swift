//
//  File.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 06.11.2021.
//

import UIKit

public extension UIView {
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviews(_ views: [UIView]) {
        views.forEach{ addSubview($0) }
    }
}
