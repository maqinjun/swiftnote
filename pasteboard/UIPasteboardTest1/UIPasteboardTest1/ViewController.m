//
//  ViewController.m
//  UIPasteboardTest1
//
//  Created by maqj on 5/13/16.
//  Copyright © 2016 maqj. All rights reserved.
//

#import "EmmLib.h"
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [EmmLib pasteboardHookEnable:YES];
    
//    NSLog(@"%@", UIPasteboardNameGeneral);
//    NSLog(@"%@", UIPasteboardNameFind);
//    
//    UIPasteboard *paster = [UIPasteboard generalPasteboard];
//    paster.string = @"string to test2";
//
//    paster.image = [UIImage imageNamed:@"test.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
