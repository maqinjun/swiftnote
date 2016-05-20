//
//  SwiftClass.swift
//  SwiftObjcCompatibility
//
//  Created by maqj on 5/20/16.
//  Copyright © 2016 maqj. All rights reserved.
//

import UIKit

class SwiftClass: NSObject {
    func objcMethodTest() -> Void {
        let objcClass = ObjcClass()
        objcClass.test()
        
        let testString = objcClass.testWithBlock({ (value: String!) -> String! in
            print("SwiftClass " + value)
            
            return "I'm from SwiftClass"
            }, name: "swiftclass name")
        
        print(testString)
    }
}
