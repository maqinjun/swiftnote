//
//  ObjcClass.m
//  ObjcSwiftCompatibility
//
//  Created by maqj on 5/20/16.
//  Copyright © 2016 maqj. All rights reserved.
//

#import "ObjcClass.h"
#import "ObjcSwiftCompatibility-Swift.h"

@implementation ObjcClass
- (void)test{
    SwiftClass *swiftClass = [[SwiftClass alloc] init];
    NSString *retString = [swiftClass testSwiftMethod:@"ObjcClass name" block:^NSString * _Nonnull(NSString * _Nonnull value) {
        NSLog(@"%s, %@",__FUNCTION__, value);
        
        return @"From ObjcClass return.";
    }];
    
    NSLog(@"%@", retString);
    
}
@end
