//
//  UIImageView.swift
//  ANF Code Test
//
//  Created by Nikhil on 28/09/22.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping (_ image: UIImage) -> Void) {
        DownloadManager.shared.downloadImageData(from: url) { data in
            guard let imageData = data, let image = UIImage(data: imageData) else {
                return
            }
            
            completion(image)
        }
    }
}
