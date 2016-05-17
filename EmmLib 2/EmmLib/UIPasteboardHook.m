//
//  UIPasteboardHook.m
//  EmmLib
//
//  Created by dengxiang on 3/7/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UIPasteboardHook.h"
//#import "fishhook.h"
#import "CaptainHook/CaptainHook.h"
#include <Foundation/NSString.h>
#import "PersistenceUtil.h"
@import UIKit;

static NSString *const uuPasteboardName = @"com.uusafe.emm.pasteboard";

CHDeclareClass(UIPasteboard);

/*
 Hook 类方法。
 */
CHClassMethod(0, UIPasteboard*, UIPasteboard, generalPasteboard){
    
    if (isGeneral) {
        NSLog(@"%s, generalPasteboard", __FUNCTION__);
        return CHSuper(0, UIPasteboard, generalPasteboard);
    }
    
    NSLog(@"%s, myGeneralPasteboard", __FUNCTION__);
    
    return [UIPasteboard pasteboardWithName:uuPasteboardName create:YES];
}

CHClassMethod(0, UIPasteboard*, UIPasteboard, pasteboardWithUniqueName){
    if (isGeneral) {
        NSLog(@"%s, pasteboardWithUniqueName", __FUNCTION__);

        return CHSuper(0, UIPasteboard, pasteboardWithUniqueName);
    }
    
    NSLog(@"%s, myPasteboardWithUniqueName", __FUNCTION__);

    return [UIPasteboard pasteboardWithName:uuPasteboardName create:YES];
}

CHClassMethod(2, UIPasteboard*, UIPasteboard, pasteboardWithName, NSString*, pasteboardName, create, BOOL, isCreate){
    if (isGeneral) {
        return CHSuper(2, UIPasteboard, pasteboardWithName, pasteboardName, create, isCreate);
    }
    
    return CHSuper(2, UIPasteboard, pasteboardWithName, uuPasteboardName, create, isCreate);
}

/*
 Hook 类属性。
 */
CHMethod(0, UIImage*, UIPasteboard, image){
    UIImage *thisImage = CHSuper(0, UIPasteboard, image);
    
    NSLog(@"####### HOOKED UIPasteboard, %s, %@", __FUNCTION__, thisImage);
    
    return thisImage;
}

CHMethod(1, void, UIPasteboard, setImage, UIImage*, image){
    NSLog(@"####### HOOKED UIPasteboard, %s, %@", __FUNCTION__, image);
    
    CHSuper(1, UIPasteboard, setImage, image);
}

CHMethod(0, NSArray*, UIPasteboard, items){
    NSArray *thisItems = CHSuper(0, UIPasteboard, items);
    NSLog(@"####### HOOKED UIPasteboard, %s, %@", __FUNCTION__, thisItems);
    return thisItems;
}

CHMethod(1, void, UIPasteboard, setItems, NSArray*, items){
    NSLog(@"####### HOOKED UIPasteboard, %s, %@", __FUNCTION__, items);
    
    NSDictionary *item = items[0];
    NSData *data = item[@"public.utf8-plain-text"];
    NSString *curString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (curString &&
        !isGeneral) {
        isGeneral = YES;
        
        UIPasteboard *paster = [UIPasteboard generalPasteboard];
        [PersistenceUtil shared].string = paster.string;
        
        isGeneral = NO;
    }
    
    CHSuper(1, UIPasteboard, setItems, items);
}

CHMethod(0, NSString *, UIPasteboard, string)
{
    NSLog(@"####### HOOKED UIPasteboard string ##########");
    NSString * s = CHSuper(0, UIPasteboard, string);
    NSLog(@"string:%@", s);
    if (!isGeneral) {
        isGeneral = YES;
        UIPasteboard *paster = [UIPasteboard generalPasteboard];
        NSString *generalStr = paster.string;
        isGeneral = NO;
        
        NSString *lastStr = [PersistenceUtil shared].string;
        
        if ([generalStr isEqualToString:lastStr]) {
            return s;
        }else{
            return generalStr;
        }
    }
    return s;
}

CHMethod(1, void, UIPasteboard, setString, NSString *, s) {
    NSLog(@"####### HOOKED UIPasteboard setString ##########");
    
    if (!isGeneral) {
        isGeneral = YES;
        
        UIPasteboard *paster = [UIPasteboard generalPasteboard];
        [PersistenceUtil shared].string = paster.string;
        
        isGeneral = NO;
    }
    
    CHSuper(1, UIPasteboard, setString, s);
}

/*
 Hook 对象方法。
 */
CHMethod(2, void, UIPasteboard, setData, NSData *, data, forPasteboardType, NSString *, pasteboardType) {
    NSLog(@"####### HOOKED UIPasteboard setData ##########");
    
    CHSuper(2, UIPasteboard, setData, data, forPasteboardType, pasteboardType);
}

CHMethod(2, void, UIPasteboard, setValue, id, value, forPasteboardType, NSString *, pasteboardType) {
    NSLog(@"####### HOOKED UIPasteboard setValue ##########");
    
    CHSuper(2, UIPasteboard, setValue, value, forPasteboardType, pasteboardType);
}

BOOL isGeneral = NO;

@implementation UIPasteboardHook

+ (void) hook{
    NSLog(@"####### HOOKED UIPasteboardHook hook ##########");
    
    CHLoadClass(UIPasteboard);

    CHHook(2, UIPasteboard, setData, forPasteboardType);
    CHHook(2, UIPasteboard, setValue, forPasteboardType);
    CHHookProperty(UIPasteboard, string, setString);
    CHHookProperty(UIPasteboard, items, setItems);
    CHHookProperty(UIPasteboard, image, setImage);
    
    CHClassHook(0, UIPasteboard, generalPasteboard);
    CHClassHook(0, UIPasteboard, pasteboardWithUniqueName);
    CHClassHook(2, UIPasteboard, pasteboardWithName, create);
}


@end
