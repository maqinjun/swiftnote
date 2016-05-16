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

CHDeclareClass(NSString);

CHMethod(0, NSString *, NSString, uppercaseString) {
    //  NSLog(@"###uppercaseString###");
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
    return s;
}

CHMethod(0, UIImage *, UIPasteboard, image){
    NSLog(@"####### HOOKED UIPasteboard image ##########");

    UIImage *image = CHSuper(0, UIPasteboard, image);
    return image;
}

CHMethod(0, NSArray* , UIPasteboard, strings){
    NSLog(@"####### HOOKED UIPasteboard strings ##########");

    NSArray* strings = CHSuper(0, UIPasteboard, strings);
    return strings;
}

CHMethod(1, void, UIPasteboard, setStrings, NSArray*, strings){
    NSLog(@"####### HOOKED UIPasteboard setStrings ##########");

    CHSuper(1, UIPasteboard, setStrings, strings);
}

CHMethod(1, void, UIPasteboard, setImage, UIImage*, image){
    
    NSLog(@"####### HOOKED UIPasteboard setImage ##########");

    CHSuper(1, UIPasteboard, setImage, image);
}

CHMethod(1, void, UIPasteboard, setString, NSString *, s) {
    NSLog(@"####### HOOKED UIPasteboard setString ##########");
    
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

CHMethod(2, void, UIPasteboard, setValue, id, value, forKey, NSString*, forKeyKey){
    NSLog(@"####### HOOKED UIPasteboard setValue:forKey: ##########");

    CHSuper(2, UIPasteboard, setValue, value, forKey, forKeyKey);
}

CHMethod(2, void, UIPasteboard, setValue, id, value, forKeyPath, NSString*, forKeyPathKey){
    NSLog(@"####### HOOKED UIPasteboard  setValue:forKeyPath: ##########");

    CHSuper(2, UIPasteboard, setValue, value, forKeyPath, forKeyPathKey);
}

//CHMethod(2, void, UIPasteboard, setValue, id, value, forUndefinedKey, NSString*, undefineKey){
//    NSLog(@"####### HOOKED UIPasteboard setValue:forUndefinedKey: ##########");
//
//    CHSuper(2, UIPasteboard, setValue, value, forUndefinedKey, undefineKey);
//}

CHMethod(1, id, UIPasteboard, valueForKey, NSString*, key){
    NSLog(@"####### HOOKED UIPasteboard valueForKey: ##########");

    id value = CHSuper(1, UIPasteboard, valueForKey, key);
    return value;
}

CHMethod(1, id, UIPasteboard, valueForKeyPath, NSString*, key){
    NSLog(@"####### HOOKED UIPasteboard valueForKeyPath: ##########");

    id value = CHSuper(1, UIPasteboard, valueForKeyPath, key);
    return value;
}

//CHMethod(1, id, UIPasteboard, valueForUndefinedKey, NSString*, key){
//    NSLog(@"####### HOOKED UIPasteboard valueForUndefinedKey: ##########");
//
//    id value = CHSuper(1, UIPasteboard, valueForUndefinedKey, key);
//    return value;
//}


typedef UIPasteboard* (*UIPasteboard_generalPasteboard__IMP)();
static UIPasteboard_generalPasteboard__IMP original_UIPasteboard_generalPasteboard_;
static UIPasteboard* uu_UIPasteboard = NULL;

CHClassMethod(0, UIPasteboard*, UIPasteboard, generalPasteboard){
    
    NSLog(@"####### HOOKED UIPasteboard generalPasteboard ##########");
    
    if(!uu_UIPasteboard){
        uu_UIPasteboard = [UIPasteboard pasteboardWithName:@"com.uusafe.emm.pasteboard" create:TRUE];
        [uu_UIPasteboard addObserver:[UIPasteboardHook shared] forKeyPath:@"string" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    
    return uu_UIPasteboard;


    UIPasteboard *paste = CHSuper(0, UIPasteboard, generalPasteboard);
    return paste;
}

//void ABAddressBookRequestAccessWithCompletion(ABAddressBookRef addressBook,  ABAddressBookRequestAccessCompletionHandler completion)
//static UIPasteboard * (*orig__UIPasteboard_generalPasteboard_)();
//static UIPasteboard * my_UIPasteboard_generalPasteboard(){
//  NSLog(@"####### HOOKED my_UIPasteboard_generalPasteboard##########");
//  return [UIPasteboard generalPasteboard];
//}



UIPasteboard* replaced_UIPasteboard_generalPasteboard_() {
    NSLog(@"#####Entering generalPasteboard");
    if(!uu_UIPasteboard){
        uu_UIPasteboard = [UIPasteboard pasteboardWithName:@"com.uusafe.emm.pasteboard" create:TRUE];
    }
    
    return uu_UIPasteboard;
}

CHDeclareClass(UIResponder);

CHMethod(1, void, UIResponder, select, id , sender)
{
    NSLog(@"####### HOOKED UIResponder select ##########");
 
    CHSuper(1, UIResponder, select, sender);
}

CHMethod(1, void, UIResponder, paste, id , sender)
{
    NSLog(@"####### HOOKED UIResponder paste ##########");
    
    CHSuper(1, UIResponder, paste, sender);
}

CHMethod(1, void, UIResponder, copy, id, sender){
    NSLog(@"####### HOOKED UIResponder copy ##########");

    CHSuper(1, UIResponder, copy, sender);
}

CHMethod(1, void, UIResponder, selectAll, id, sender){
    NSLog(@"####### HOOKED UIResponder selectAll ##########");

    CHSuper(1, UIResponder, selectAll, sender);
}

CHMethod(1, void, UIResponder, cut, id, sender){
    NSLog(@"####### HOOKED UIResponder cut ##########");

    CHSuper(1, UIResponder, cut, sender);
}

CHMethod(2, BOOL, UIResponder, canPerformAction, SEL, action, withSender, id, sender){
    NSLog(@"####### HOOKED UIResponder canPerformAction:withSender: ##########");
    
    BOOL ret = CHSuper(2, UIResponder, canPerformAction, action, withSender, sender);
    
    NSLog(@"%d, action: %@, sender: %@",ret, NSStringFromSelector(action), [sender description]);

    return ret;
}


@implementation UIPasteboardHook

+(UIPasteboardHook*)shared{
    NSLog(@"%s", __FUNCTION__);
    
    static dispatch_once_t once_t;
    static UIPasteboardHook *paste;
    dispatch_once(&once_t, ^{
        paste = [UIPasteboardHook new];
    });
    
    return paste;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"%@, %@", keyPath, change);
}

+ (void) hook{
    NSLog(@"####### HOOKED UIPasteboardHook hook ##########");
    CHLoadClass(NSString);
    CHHook(0, NSString, uppercaseString);
    //  CHHook(1, NSString, stringWithUTF8String);
    CHLoadClass(UIPasteboard);
//    Method m = class_getClassMethod([UIPasteboard class], @selector(generalPasteboard));
//    original_UIPasteboard_generalPasteboard_ = method_setImplementation(m, replaced_UIPasteboard_generalPasteboard_);
    CHHook(2, UIPasteboard, setData, forPasteboardType);
    CHHook(2, UIPasteboard, setValue, forPasteboardType);
    CHHook(2, UIPasteboard, setValue, forKey);
    CHHook(2, UIPasteboard, setValue, forKeyPath);
    CHHook(1, UIPasteboard, valueForKey);
    CHHook(1, UIPasteboard, valueForKeyPath);
    
    CHClassHook(0, UIPasteboard, generalPasteboard);
    
    CHHookProperty(UIPasteboard, string, setString);
    CHHookProperty(UIPasteboard, strings, setStrings);
    CHHookProperty(UIPasteboard, image, setImage);
    
    CHLoadClass(UIResponder);
    CHHook(1, UIResponder, select);
    CHHook(1, UIResponder, paste);
    CHHook(1, UIResponder, copy);
    CHHook(1, UIResponder, selectAll);
    CHHook(1, UIResponder, cut);
    CHHook(2, UIResponder, canPerformAction, withSender);

//    CHHook(1, NSObject, );
    
    //  CHLoadLateClass(UIPasteboard);
    //  CHClassHook(0, UIPasteboard, generalPasteboard);
    //
    //  rebind_symbols((struct rebinding[1]){
    //    {"+[UIPasteboard generalPasteboard]", my_UIPasteboard_generalPasteboard, (void *)&orig__UIPasteboard_generalPasteboard_},
    //  }, 1);
    
}


@end
