//
//  CropImageWithBeiziarpath.swift
//  MaskImageDraw
//
//  Created by Mehedi Hasan on 13/3/22.
//

import Foundation
import UIKit

extension UIImage {
    func imageByApplyingClippingBezierPath(_ path: UIBezierPath) -> UIImage {
        // Mask image using path
        guard let let maskedImage = imageByApplyingMaskingBezierPath(path) else { return nil }

        // Crop image to frame of path
        let croppedImage = UIImage(cgImage: maskedImage.cgImage!.cropping(to: path.bounds)!)
        
        return croppedImage
    }
    
    func imageByApplyingMaskingBezierPath(_ path: UIBezierPath) -> UIImage? {
        // Define graphic context (canvas) to paint on
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()

        // Set the clipping mask
        path.addClip()
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        guard let maskedImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }

        // Restore previous drawing context
        context.restoreGState()
        UIGraphicsEndImageContext()

        return maskedImage
    }
    
    func clip(_ path: UIBezierPath) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)

        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        path.addClip()
        self.draw(in: frame)

        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        context?.restoreGState()
        UIGraphicsEndImageContext()

        return newImage
    }
}
