//
//  UIPasteboardHook.h
//  EmmLib
//
//  Created by dengxiang on 3/7/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIPasteboardHook : NSObject
+(UIPasteboardHook*)shared;
+ (void) hook;
@end
