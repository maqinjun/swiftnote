//
//  UIiCloudSyncHook.m
//  EmmLib
//
//  Created by maqj on 5/20/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UIiCloudSyncHook.h"
#import "CaptainHook/CaptainHook.h"

typedef  NSError* __unsafe_unretained* NSErrorPointer;


@implementation UIiCloudSyncHook

BOOL isExcludedFromBackupKey = YES;

CHDeclareClass(NSURL)


CHMethod(3, BOOL, NSURL, setResourceValue, id, value, forKey, NSString*, key, error, NSError* __unsafe_unretained*, err){
    NSLog(@"####### HOOKED NSURL, %s", __FUNCTION__);
    
    id curValue = value;
    
    if([key isEqualToString:NSURLIsExcludedFromBackupKey]){
        curValue = @(isExcludedFromBackupKey);
    }
    
    return CHSuper(3, NSURL, setResourceValue, curValue, forKey, key, error, err);
}

CHMethod(2, BOOL, NSURL, setResourceValues, NSDictionary*, keyedValues, error,  NSError* __unsafe_unretained*, err){
    NSLog(@"####### HOOKED NSURL, %s", __FUNCTION__);

    NSMutableDictionary *mutDic = [keyedValues mutableCopy];
    
    id value = mutDic[NSURLIsExcludedFromBackupKey];
    if (value != nil) {
        mutDic[NSURLIsExcludedFromBackupKey] = @(isExcludedFromBackupKey);
    }
    return CHSuper(2, NSURL, setResourceValues, [mutDic copy], error, err);
}

+ (void)hook{
    CHLoadClass(NSURL);
    
    CHHook(3, NSURL, setResourceValue, forKey, error);
    CHHook(2, NSURL, setResourceValues, error);
}
@end
