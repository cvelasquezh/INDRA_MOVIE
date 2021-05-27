//
//  UIImageView+Extension.swift
//  IndraMovieApp
//
//  Created by MDP-DESARROLLADOR on 5/24/21.
//

import UIKit

extension UIImageView {
    
    func imageFromServerURL(urlString: String, placeHolderImage: UIImage) {
        
        if self.image == nil {
            self.image = placeHolderImage
        }
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                let image = UIImage(data: data)
                self.image = image
            }
            
        }.resume()
    }
}
