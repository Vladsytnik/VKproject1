//
//  Extension cell.swift
//  vk
//
//  Created by Vlad Sytnik on 12.07.2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    func downloadImageFrom(link url: String) {
        
        guard let url = URL(string: url) else {return}
        URLSession(configuration: .default)
            .dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let response = response {
                print(response)
            }

            if let data = data {
                do {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.imageView?.image = image
                    }
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
}
