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

static NSRecursiveLock * lock = nil;

__attribute__ ((constructor)) void curEntry(){
    lock = [[NSRecursiveLock alloc] init];
}

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
    
    UIPasteboard *pasteboard = CHSuper(2, UIPasteboard, pasteboardWithName, uuPasteboardName, create, isCreate);
    pasteboard.persistent = YES;
    return pasteboard;
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

CHMethod(0, NSArray*, UIPasteboard, images){
    
    NSLog(@"####### HOOKED UIPasteboard images ##########");

    NSArray *arr = CHSuper(0, UIPasteboard, images);
    return arr;
}

CHMethod(1, void, UIPasteboard, setImages, NSArray*, images){
    
    NSLog(@"####### HOOKED UIPasteboard setImages ##########");

    CHSuper(1, UIPasteboard, setImages, images);
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
    if ([lock tryLock] &&
        curString &&
        !isGeneral) {
        isGeneral = YES;
        
        UIPasteboard *paster = [UIPasteboard generalPasteboard];
        [PersistenceUtil shared].string = paster.string;
        
        isGeneral = NO;
        
        [lock unlock];
    }
    
    CHSuper(1, UIPasteboard, setItems, items);
}

CHMethod(0, NSString *, UIPasteboard, string)
{
    NSLog(@"####### HOOKED UIPasteboard string ##########");
    NSString * s = CHSuper(0, UIPasteboard, string);
    NSLog(@"string:%@", s);
    if ([lock tryLock]&&
        !isGeneral) {
        isGeneral = YES;
        UIPasteboard *paster = [UIPasteboard generalPasteboard];
        NSString *generalStr = paster.string;
        isGeneral = NO;
        
        [lock unlock];
        
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
    
    if ([lock tryLock] &&
        !isGeneral) {
        isGeneral = YES;
        UIPasteboard *paster = [UIPasteboard generalPasteboard];
        [PersistenceUtil shared].string = paster.string;
        isGeneral = NO;
        [lock unlock];
    }
    
    CHSuper(1, UIPasteboard, setString, s);
}

CHMethod(0, NSArray*, UIPasteboard, strings){
    
    NSLog(@"####### HOOKED UIPasteboard strings ##########");

    NSArray *arr = CHSuper(0, UIPasteboard, strings);
    
    if ([lock tryLock] &&
        !isGeneral) {
        isGeneral = YES;
        UIPasteboard *paster = [UIPasteboard generalPasteboard];
        NSArray *generalStrings = paster.strings;
        isGeneral = NO;
        
        [lock unlock];
        
        NSArray *lastStrings = [PersistenceUtil shared].strings;
        
        if ([generalStrings isEqualToArray:lastStrings]) {
            return arr;
        }else{
            return generalStrings;
        }
    }
    
    return arr;
}

CHMethod(1, void, UIPasteboard, setStrings, NSArray*, strings){
    
    NSLog(@"####### HOOKED UIPasteboard setStrings ##########");

    if ([lock tryLock] &&
        !isGeneral) {
        isGeneral = YES;
        UIPasteboard *paster = [UIPasteboard generalPasteboard];
        [PersistenceUtil shared].strings = paster.strings;
        isGeneral = NO;
        [lock unlock];
    }
    
    CHSuper(1, UIPasteboard, setStrings, strings);
}

CHMethod(0, NSURL*, UIPasteboard, URL){
    
    NSLog(@"####### HOOKED UIPasteboard URL ##########");

    NSURL *thisUrl = CHSuper(0, UIPasteboard, URL);
    return thisUrl;
}

CHMethod(1, void, UIPasteboard, setURL, NSURL*, url){
    
    NSLog(@"####### HOOKED UIPasteboard setURL ##########");

    CHSuper(1, UIPasteboard, setURL, url);
}

CHMethod(0, NSArray*, UIPasteboard, URLs){
    
    NSLog(@"####### HOOKED UIPasteboard URLs ##########");

    NSArray *arr = CHSuper(0, UIPasteboard, URLs);
    return arr;
}

CHMethod(1, void, UIPasteboard, setURLs, NSArray*, urls){
    
    NSLog(@"####### HOOKED UIPasteboard setURLs ##########");

    CHSuper(1, UIPasteboard, setURLs, urls);
}

CHMethod(0, UIColor*, UIPasteboard, color){
    
    NSLog(@"####### HOOKED UIPasteboard color ##########");

    UIColor *color = CHSuper(0, UIPasteboard, color);
    return color;
}

CHMethod(1, void, UIPasteboard, setColor, UIColor*, color){
    
    NSLog(@"####### HOOKED UIPasteboard setColor ##########");

    CHSuper(1, UIPasteboard, setColor, color);
}

CHMethod(0, NSArray*, UIPasteboard, colors){
    
    NSLog(@"####### HOOKED UIPasteboard colors ##########");

    NSArray *arr = CHSuper(0, UIPasteboard, colors);
    return arr;
}

CHMethod(1, void, UIPasteboard, setColors, NSArray*, colors){
    
    NSLog(@"####### HOOKED UIPasteboard setColors ##########");

    CHSuper(1, UIPasteboard, setColors, colors);
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
    CHHookProperty(UIPasteboard, strings, setStrings);
    CHHookProperty(UIPasteboard, image, setImage);
    CHHookProperty(UIPasteboard, images, setImages);
    CHHookProperty(UIPasteboard, URL, setURL);
    CHHookProperty(UIPasteboard, URLs, setURLs);
    CHHookProperty(UIPasteboard, color, setColor);
    CHHookProperty(UIPasteboard, colors, setColors);
    CHHookProperty(UIPasteboard, items, setItems);

    CHClassHook(0, UIPasteboard, generalPasteboard);
    CHClassHook(0, UIPasteboard, pasteboardWithUniqueName);
    CHClassHook(2, UIPasteboard, pasteboardWithName, create);
}


@end
