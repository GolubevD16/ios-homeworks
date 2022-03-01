//
//  PhotoData.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.11.2021.
//

import Foundation
import UIKit


class PhotosData {
    
    static func getPhotos() -> [UIImage] {
        var images: [UIImage] = []
        let photosNameAssets = ["airbus", "bear", "belka", "bird", "car", "dog", "dragon", "ejik", "horse", "kot", "kunica", "liji", "monako", "moscow", "nos", "riba", "sky", "slon", "voda", "vodopad", "cafe"]
        photosNameAssets.forEach{
            images.append(UIImage(named: $0) ?? UIImage())
        }
        return images
    }
    
    static func getPhotosMedia() -> [UIImage] {
        var images: [UIImage] = []
        let photosNameAssets = ["annecy", "annecy2", "avatar", "cafe", "checkmark", "mountain", "skyscraper", "sunset"]
        photosNameAssets.forEach{
            let img: UIImage = UIImage(named: $0, in: Bundle(identifier: "$(PRODUCT_BUNDLE_IDENTIFIER)"), with: nil) ?? UIImage()
            images.append(img)
        }
        return images
    }
}
