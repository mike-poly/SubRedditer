//
//  RedditWebViewController.swift
//  SubReditter
//
//  Created by Michael Polyakov on 2021-12-10.
//  Copyright © 2021 MIchael Polyakov. All rights reserved.
//

import UIKit
import WebKit

class RedditWebViewController: UIViewController {

    let webView = WKWebView()
    
    public var url: URL? = nil
    
    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL()
    }
    
    func loadURL() {
        guard let url = self.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }

}
