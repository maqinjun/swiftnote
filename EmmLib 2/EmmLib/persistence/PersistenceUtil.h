//
//  PersistenceUtil.h
//  EmmLib
//
//  Created by maqj on 5/16/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PersistenceUtil : NSObject
+ (PersistenceUtil*)shared;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, copy) NSArray *strings;

@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) NSArray *urls;

@property (nonatomic, copy) UIImage *image;
@property (nonatomic, copy) NSArray *images;

@property (nonatomic, copy) UIColor *color;
@property (nonatomic, copy) NSArray *colors;
@end
