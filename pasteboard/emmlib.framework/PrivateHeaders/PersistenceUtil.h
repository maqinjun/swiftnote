//
//  PersistenceUtil.h
//  EmmLib
//
//  Created by maqj on 5/16/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistenceUtil : NSObject
+ (PersistenceUtil*)shared;
@property (atomic, copy) NSString *string;
@end
