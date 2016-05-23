//
//  EmmLib.m
//  EmmLib
//
//  Created by dengxiang on 2/25/16.
//  Copyright © 2016 uusafe. All rights reserved.
//
//#import "CaptainHook/CaptainHook.h"

#import "EmmLib.h"
#import "ContactsHook.h"
#import "UIPasteboardHook.h"
#import "UIiCloudSyncHook.h"
#import <sys/xattr.h>

//CHDeclareClass(Talker);
//
//CHMethod(1, void, Talker, say, id, arg1)
//{
//    NSString* tmp=@"Hello, Android!";
//
//    CHSuper(1, Talker, say, tmp);
//}
//

__attribute__((constructor)) static void entry()
{
    NSLog(@"Hello, Ice And Fire!");
    //  [ContactsHook hook];
    [UIPasteboardHook hook];
    [UIiCloudSyncHook hook];

    if ([EmmLib icloudSyncEnable:NO]) {
        NSLog(@"icloud sync enable success!");
    }else{
        NSLog(@"icloud sync enable failed!");
    }
}

@implementation EmmLib
+ (void)pasteboardHookEnable:(BOOL)is{
    @synchronized (self) {
        isGeneral = !is;
    }
}

+ (BOOL)icloudSyncEnable:(BOOL)is{
    @synchronized (self) {
        isExcludedFromBackupKey = !is;
        return [UIiCloudSyncHook addNotBackUpiCloud];
    }
}
@end
