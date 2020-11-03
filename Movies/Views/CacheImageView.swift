//
//  UIImageView+Cache.swift
//  Movies
//
//  Created by Dogan Ekici on 3.11.2020.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CacheImageView: UIImageView {
    var imageUrlString: String?
    
    func loadImage(witUrlString urlString: String?) {
        imageUrlString = urlString
        
        guard let urlString = urlString else{
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString){
            self.image = imageFromCache
            return
        }
        
        let request = URLRequest(url: URL(string: urlString)!)
        URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    if self?.imageUrlString == urlString{
                        self?.alpha = 0
                        self?.image = image
                        UIView.animate(withDuration: 1) {
                            self?.alpha = 1
                        }
                    }
                }
            }
        }).resume()
    }
}
