//
//  ViewController.swift
//  SwiftObjcCompatibility
//
//  Created by maqj on 5/20/16.
//  Copyright © 2016 maqj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let swiftClass = SwiftClass()
        swiftClass.objcMethodTest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

