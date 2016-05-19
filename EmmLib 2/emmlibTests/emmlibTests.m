//
//  emmlibTests.m
//  emmlibTests
//
//  Created by maqj on 5/18/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PersistenceUtil.h"

@interface emmlibTests : XCTestCase

@end

@implementation emmlibTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
//    NSString *testPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"strings"];
    
    NSString *string = @"test string";
    NSArray *strings = @[@"test string1", @"test string2"];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSArray *urls = @[url, url];
    UIImage *image = [self imageWithColor:[UIColor blueColor]];
    NSArray *images = @[image, image];
    UIColor *color = [UIColor blueColor];
    NSArray *colors = @[color, color];
    
    [PersistenceUtil shared].string = string;
    XCTAssert([[PersistenceUtil shared].string isEqual:string]);
    
    [PersistenceUtil shared].strings = strings;
    XCTAssert([[PersistenceUtil shared].strings isEqual:strings]);
    
    [PersistenceUtil shared].url = url;
    XCTAssert([[PersistenceUtil shared].url isEqual:url]);
    
    [PersistenceUtil shared].urls = urls;
    XCTAssert([[PersistenceUtil shared].urls isEqual:urls]);
    
    [PersistenceUtil shared].image = image;
    XCTAssert([PersistenceUtil shared].image != nil);
    
    [PersistenceUtil shared].images = images;
    XCTAssert([PersistenceUtil shared].images != nil && [PersistenceUtil shared].images.count == 2);
    
    [PersistenceUtil shared].color = color;
    XCTAssert([[PersistenceUtil shared].color isEqual:color]);
    
    [PersistenceUtil shared].colors = colors;
    XCTAssert([[PersistenceUtil shared].colors isEqual:colors]);
}

- (UIImage*)imageWithColor:(UIColor*)color{
    CGRect rect = CGRectMake(0.f, 0.f, 1.f, 1.f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
