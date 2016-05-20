//
//  ViewController.m
//  ObjcSwiftCompatibility
//
//  Created by maqj on 5/20/16.
//  Copyright © 2016 maqj. All rights reserved.
//

#import "ViewController.h"
#import "ObjcClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ObjcClass *objcClass = [ObjcClass new];
    [objcClass test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
