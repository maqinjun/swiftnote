//
//  UIiCloudSyncHook.h
//  EmmLib
//
//  Created by maqj on 5/20/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

extern BOOL isExcludedFromBackupKey;

@interface UIiCloudSyncHook : NSObject
+ (void)hook;
@end
