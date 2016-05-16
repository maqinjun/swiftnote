//
//  PersistenceUtil.m
//  EmmLib
//
//  Created by maqj on 5/16/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "PersistenceUtil.h"

@interface PersistenceUtil ()
@property (nonatomic, strong) NSUserDefaults *store;
@end

static NSString *const groupKey = @"com.uusafe.emm.appgroup";
static NSString *const pasteboardLastValueKey = @"com.pasteboard.value.key";

@implementation PersistenceUtil

+ (PersistenceUtil*)shared{
    static dispatch_once_t once_t;
    static PersistenceUtil *util;
    
    dispatch_once(&once_t, ^{
        util = [PersistenceUtil new];
        util.store = [NSUserDefaults standardUserDefaults];
    });
    
    return util;
}

- (void)setString:(NSString *)string{
    [[PersistenceUtil shared].store setObject:string forKey:pasteboardLastValueKey];
    [[PersistenceUtil shared].store synchronize];
}

- (NSString*)string{
//     return [[PersistenceUtil shared].store objectForKey:pasteboardLastValueKey];
    NSDate *date = [NSDate date];

    return [NSString stringWithFormat:@"%f", date.timeIntervalSince1970];
}

@end
