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
#import "JRSwizzle.h"

CHDeclareClass(NSString);

CHMethod(0, NSString *, NSString, uppercaseString) {
    NSLog(@"###uppercaseString###");
    return CHSuper(0, NSString, uppercaseString);
}

//CHMethod(1, NSString *, NSString, stringWithUTF8String, const char *, nullTerminatedCString) {
//  NSLog(@"###stringWithUTF8String###");
//  return CHSuper(1, NSString, stringWithUTF8String, nullTerminatedCString);
//}

//CHConstructor
//{
//  CHLoadClass(NSString);
//  CHHook(0, NSString, uppercaseString);
//}
//

@import UIKit;


CHDeclareClass(UIPasteboard);

CHMethod(0, NSString *, UIPasteboard, string)
{
    NSLog(@"####### HOOKED UIPasteboard string ##########");
    NSString * s = CHSuper(0, UIPasteboard, string);
    NSLog(@"string:%@", s);
//    if (!isGeneral) {
//        isGeneral = YES;
//        UIPasteboard *paster = [UIPasteboard generalPasteboard];
//        NSString *generalStr = paster.string;
//        isGeneral = NO;
//        
//        NSString *lastStr = [PersistenceUtil shared].string;
//        
//        if ([generalStr isEqualToString:lastStr]) {
//            return s;
//        }else{
//            return generalStr;
//        }
//    }
    return s;
}

CHMethod(1, void, UIPasteboard, setString, NSString *, s) {
    NSLog(@"####### HOOKED UIPasteboard setString ##########");
    
//    if (!isGeneral) {
//        isGeneral = YES;
//
//        UIPasteboard *paster = [UIPasteboard generalPasteboard];
//        [PersistenceUtil shared].string = paster.string;
//        
//        isGeneral = NO;
//    }
    
    CHSuper(1, UIPasteboard, setString, s);
}

CHMethod(2, void, UIPasteboard, setData, NSData *, data, forPasteboardType, NSString *, pasteboardType) {
    NSLog(@"####### HOOKED UIPasteboard setData ##########");
    
    CHSuper(2, UIPasteboard, setData, data, forPasteboardType, pasteboardType);
}

CHMethod(2, void, UIPasteboard, setValue, id, value, forPasteboardType, NSString *, pasteboardType) {
    NSLog(@"####### HOOKED UIPasteboard setValue ##########");
    
    CHSuper(2, UIPasteboard, setValue, value, forPasteboardType, pasteboardType);
}

//void ABAddressBookRequestAccessWithCompletion(ABAddressBookRef addressBook,  ABAddressBookRequestAccessCompletionHandler completion)
//static UIPasteboard * (*orig__UIPasteboard_generalPasteboard_)();
//static UIPasteboard * my_UIPasteboard_generalPasteboard(){
//  NSLog(@"####### HOOKED my_UIPasteboard_generalPasteboard##########");
//  return [UIPasteboard generalPasteboard];
//}


typedef UIPasteboard* (*UIPasteboard_generalPasteboard__IMP)();
static UIPasteboard_generalPasteboard__IMP original_UIPasteboard_generalPasteboard_;
static UIPasteboard* uu_UIPasteboard = NULL;

UIPasteboard* replaced_UIPasteboard_generalPasteboard_() {
    NSLog(@"#####Entering generalPasteboard");
    if(!uu_UIPasteboard){
        uu_UIPasteboard = [UIPasteboard pasteboardWithName:@"com.uusafe.emm.pasteboard" create:TRUE];
    }
    
    return uu_UIPasteboard;
}

@interface UIPasteboard (paste)
+ (UIPasteboard*)myGeneralPasteboard;
@end

BOOL isGeneral = NO;

@implementation UIPasteboard (paste)

+ (UIPasteboard*)myGeneralPasteboard{

    if (isGeneral) {
        NSLog(@"%s, generalPasteboard", __FUNCTION__);
        return [UIPasteboard myGeneralPasteboard];
    }

    NSLog(@"%s, myGeneralPasteboard", __FUNCTION__);

    return [UIPasteboard pasteboardWithName:@"com.uusafe.emm.pasteboard" create:YES];
}

@end

//+ (UIPasteboard *)generalPasteboard;

@implementation UIPasteboardHook

+ (void) hook{
    NSLog(@"####### HOOKED UIPasteboardHook hook ##########");
    CHLoadClass(NSString);
    CHHook(0, NSString, uppercaseString);
    //  CHHook(1, NSString, stringWithUTF8String);
    CHLoadClass(UIPasteboard);
    //  Method m = class_getClassMethod([UIPasteboard class], @selector(generalPasteboard));
    //  original_UIPasteboard_generalPasteboard_ = method_setImplementation(m, replaced_UIPasteboard_generalPasteboard_);
//    CHClassHook(0, UIPasteboard, generalPasteboard);
//    CHClassHook(1, UIPasteboard, generalPasteboard);
    CHHook(2, UIPasteboard, setData, forPasteboardType);
    CHHook(2, UIPasteboard, setValue, forPasteboardType);
    CHHookProperty(UIPasteboard, string, setString);

    NSError *error;
    [[UIPasteboard class] jr_swizzleClassMethod:@selector(generalPasteboard) withClassMethod:@selector(myGeneralPasteboard) error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    
    //CHLoadLateClass(UIPasteboard);
    //  CHClassHook(0, UIPasteboard, generalPasteboard);
    //
    //  rebind_symbols((struct rebinding[1]){
    //    {"+[UIPasteboard generalPasteboard]", my_UIPasteboard_generalPasteboard, (void *)&orig__UIPasteboard_generalPasteboard_},
    //  }, 1);
    
}


@end
