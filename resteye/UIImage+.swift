//
//  UIView+.swift
//  resteye
//
//  Created by K-shiro on 2022/09/28.
//

import UIKit

extension UIImage {
    var uiImage: UIImage {
        let imageRenderer = UIGraphicsImageRenderer.init(size: bounds.size)
        return imageRenderer.image { context in
                    layer.render(in: context.cgContext)
            
        }
    }
}
