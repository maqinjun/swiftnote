//
//  emmlib.h
//  emmlib
//
//  Created by maqj on 5/18/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for emmlib.
FOUNDATION_EXPORT double emmlibVersionNumber;

//! Project version string for emmlib.
FOUNDATION_EXPORT const unsigned char emmlibVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <emmlib/PublicHeader.h>


@interface EmmLib : NSObject
+ (void)pasteboardHookEnable:(BOOL)is;
@end