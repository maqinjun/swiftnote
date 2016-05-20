//
//  ObjcClass.m
//  SwiftObjcCompatibility
//
//  Created by maqj on 5/20/16.
//  Copyright © 2016 maqj. All rights reserved.
//

#import "ObjcClass.h"

@implementation ObjcClass
- (void)test{
    NSLog(@"%s", __FUNCTION__);
}

- (NSString*)testWithBlock:(NSString *(^)(NSString *))block name:(NSString *)name{
    if (block) {
        NSString *str = block(@"I'm from ObjcClass");
        
        NSLog(@"%s, %@, name = %@", __FUNCTION__, str, name);
    }
    
    return @"I'm from ObjcClass return.";
}
@end
