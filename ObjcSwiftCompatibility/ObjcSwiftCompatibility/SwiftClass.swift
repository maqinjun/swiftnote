//
//  SwiftClass.swift
//  ObjcSwiftCompatibility
//
//  Created by maqj on 5/20/16.
//  Copyright © 2016 maqj. All rights reserved.
//

import UIKit

class SwiftClass:NSObject {
     func testSwiftMethod(value: String, block:(str: String) -> String) -> String {
        
        let retString = block(str: "I'm from SwiftClass" + value)
        
        print(retString)
        
        return "I'm from SwiftClass return."
    }
}
