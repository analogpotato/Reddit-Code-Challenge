//
//  DetailView.swift
//  Reddit Code Challenge
//
//  Created by Frank Foster on 8/18/20.
//  Copyright © 2020 Frank Foster. All rights reserved.
//

import UIKit
import WebKit

class DetailView: UIViewController, WKNavigationDelegate {
    

    var urlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

                
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height
        ))
        self.view.addSubview(webView)
        let url = URL(string: urlString!)
        webView.load(URLRequest(url: url!))
        


    }
    
    



}
