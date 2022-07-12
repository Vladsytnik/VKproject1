//
//  ViewController.swift
//  vk
//
//  Created by Vlad Sytnik on 12.07.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var service: Service?
    
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeIndicator.startAnimating()
        guard let service = service else { return }
        self.title = service.name
        
        DispatchQueue.global().async {
            guard let url = URL(string: service.link) else {return}
            DispatchQueue.main.async {
                self.webView.load(URLRequest(url: url))
                self.activeIndicator.stopAnimating()
            }
        }
    }
}
