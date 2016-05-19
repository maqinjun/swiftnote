//
//  PersistenceUtil.m
//  EmmLib
//
//  Created by maqj on 5/16/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "PersistenceUtil.h"
#import <objc/runtime.h>

typedef  id(^ValueHandler)(id item);

static NSDictionary<NSString*, ValueHandler> *plistToValueHandler;

@interface PersistenceUtil ()
@property (nonatomic, strong) NSUserDefaults *store;
@end

static NSString *const groupKey = @"group.com.zhizhangyi.emmcontroller";

@implementation PersistenceUtil

+ (PersistenceUtil*)shared{
    static dispatch_once_t once_t;
    static PersistenceUtil *util;
    
    dispatch_once(&once_t, ^{
        util = [PersistenceUtil new];
        util.store = [[NSUserDefaults alloc] initWithSuiteName:groupKey];
        [util loadSetterGetter];
        [util initValueHandler];
    });
    
    return util;
}

- (void)test:(ValueHandler)handler{
    
}

- (ValueHandler)getHandler:(NSString*)name{
    ValueHandler hanler;
    
    if ([name isEqualToString:@"string"]||
        [name isEqualToString:@"strings"]){
        hanler = ^id(id item){
            return item;
        };
    }else if ([name isEqualToString:@"url"]){
        hanler = ^id(id item){
            return [NSURL URLWithString:item];
        };
    }else if ([name isEqualToString:@"urls"]){
        hanler = ^id(id items){
            NSMutableArray *urls = [NSMutableArray array];

            for(id item in items){
                [urls addObject:[NSURL URLWithString:item]];
            }
            
            return urls;
        };
    }else if ([name isEqualToString:@"image"]){
        hanler = ^id(id item){
            return [UIImage imageWithData:item];
        };
    }else if ([name isEqualToString:@"images"]){
        hanler = ^id(id items){
            NSMutableArray *images = [NSMutableArray array];
            for(id item in items){
                [images addObject:[UIImage imageWithData:item]];
            }
            return images;
        };
    }else if ([name isEqualToString:@"color"]){
        hanler = ^id(id item){
            return [NSKeyedUnarchiver unarchiveObjectWithData:item];
        };
    }else if ([name isEqualToString:@"colors"]){
        hanler = ^id(id items){
            NSMutableArray *colors = [NSMutableArray array];
            for(id item in items){
                [colors addObject:[NSKeyedUnarchiver unarchiveObjectWithData:item]];
            }
            return colors;
        };
    }else{
        @throw [NSException exceptionWithName: NSInvalidArgumentException reason: [NSString stringWithFormat: @"Invalid argument %@", name] userInfo: nil];
    }
    
    return hanler;
}

- (void)initValueHandler{
    NSMutableDictionary *handlers = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);

    for (int i = 0; i < count; i++) {
        const char *name = property_getName(properties[i]);
        NSString *pName = [NSString stringWithFormat:@"%s", name];
        
        if ([@"store" isEqualToString:pName]) {
            continue;
        }

        handlers[[pName lowercaseString]] = [self getHandler:pName];
    }
    
    free(properties);
    
    plistToValueHandler = [handlers copy];
}

- (void)loadSetterGetter{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        const char *name = property_getName(properties[i]);
        NSString *pName = [NSString stringWithFormat:@"%s", name];
        
        if ([@"store" isEqualToString:pName] ||
            [@"plistToValueHandler" isEqualToString:pName]) {
            continue;
        }
        NSString *setterName = setterForProperty(pName);
        
        [self addMethod:(IMP)UU_setter name:setterName types:"v@:@"];
        [self addMethod:(IMP)UU_getter name:getterForSetter(setterName) types:"@@:"];
    }
    
    free(properties);
}

- (void)addMethod:(IMP)method name:(NSString*)methodName types:(char*)type{
    SEL selector = NSSelectorFromString(methodName);
    
    if (![self hasSelector: selector]) {
        class_addMethod([self class], selector, (IMP)method, type);
    }else{
        class_replaceMethod([self class], selector,  (IMP)method, type);
    }
}

#pragma mark -- Override setter and getter Methods

static id valueForPlist(id item){
    id value = nil;
    if([item isKindOfClass:[NSString class]]){
        value = item;
    }else if([item isKindOfClass:[UIImage class]]){
        value = UIImageJPEGRepresentation(item, 1.f);
    }else if([item isKindOfClass:[UIColor class]]){
        value = [NSKeyedArchiver archivedDataWithRootObject:item];
    }else if([item isKindOfClass:[NSURL class]]){
        value = [NSString stringWithFormat:@"%@", item];
    }else{
        @throw [NSException exceptionWithName: NSInvalidArgumentException reason: [NSString stringWithFormat: @"Invalid argument %@", item] userInfo: nil];
    }
    return value;
}


static id plistToValue(id item, NSString *name){
    return plistToValueHandler[name](item);
}

static void UU_setter(id self, SEL _cmd, id newValue){
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterForSetter(setterName);
    getterName = [getterName lowercaseString];
    
    id value = nil;
    
    if ([newValue isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutValue = [NSMutableArray array];
        for (id item in newValue) {
            [mutValue addObject:valueForPlist(item)];
        }
        value = mutValue;
    }else{
        value = valueForPlist(newValue);
    }
    
    [[PersistenceUtil shared].store setObject:value forKey:getterName];
    [[PersistenceUtil shared].store synchronize];
}

static id UU_getter(id self, SEL _cmd){
    NSString *getterName = NSStringFromSelector(_cmd);
    getterName = [getterName lowercaseString];
    
    id value = [[PersistenceUtil shared].store objectForKey: getterName];
    return plistToValue(value, getterName);
}


static NSString *setterForProperty(NSString * key)
{
    if (key.length <= 0) { return nil; }
    NSString * firstString = [[key substringToIndex: 1] uppercaseString];
    NSString * leaveString = [key substringFromIndex: 1];
    
    return [NSString stringWithFormat: @"set%@%@:", firstString, leaveString];
}

static NSString *getterForSetter(NSString * setter)
{
    if (setter.length <= 0 || ![setter hasPrefix: @"set"] || ![setter hasSuffix: @":"]) {
        
        return nil;
    }
    
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString * getter = [setter substringWithRange: range];
    
    NSString * firstString = [[getter substringToIndex: 1] lowercaseString];
    getter = [getter stringByReplacingCharactersInRange: NSMakeRange(0, 1) withString: firstString];
    
    return getter;
}

- (BOOL)hasSelector: (SEL)selector
{
    Class observedClass = object_getClass(self);
    unsigned int methodCount = 0;
    Method * methodList = class_copyMethodList(observedClass, &methodCount);
    for (int i = 0; i < methodCount; i++) {
        
        SEL thisSelector = method_getName(methodList[i]);
        if (thisSelector == selector) {
            
            free(methodList);
            return YES;
        }
    }
    
    free(methodList);
    return NO;
}

@end
