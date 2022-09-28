//
//  UIImage+Extensions.swift
//  SportBuddy
//
//  Created by Kristof Kalai on 2022. 09. 25..
//

import UIKit

extension UIImage {
    func resize(to dimension: CGFloat) -> UIImage? {
        if max(size.width, size.height) <= dimension { return self }

        let aspectRatio = size.width / size.height
        let newSize: CGSize
        if aspectRatio > 1 { // Landscape
            newSize = CGSize(width: dimension, height: dimension / aspectRatio)
        } else { // Portrait
            newSize = CGSize(width: dimension * aspectRatio, height: dimension)
        }

        UIGraphicsBeginImageContextWithOptions(newSize, true, 1)
        draw(in: CGRect(origin: .zero, size: newSize))
        defer { UIGraphicsEndImageContext() }
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    var base64: String? {
        jpegData(compressionQuality: 0.9)?.base64EncodedString()
    }

    static func base64(string: String) -> Self? {
        guard let imageData = Data(base64Encoded: string, options: .ignoreUnknownCharacters) else { return nil }
        return Self(data: imageData)
    }
}
