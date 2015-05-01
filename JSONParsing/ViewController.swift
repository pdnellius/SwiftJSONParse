//
//  ViewController.swift
//  JSONParsing
//
//  Created by Pete Nellius on 4/30/15.
//  Copyright (c) 2015 Pete Nellius. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webview: UIWebView!
    var url = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let nsurl = NSURL(string: url){
            var request = NSURLRequest(URL: nsurl)
            webview.loadRequest(request)
        }

        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

