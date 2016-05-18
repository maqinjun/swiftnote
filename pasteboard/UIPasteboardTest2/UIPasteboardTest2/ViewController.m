//
//  ViewController.m
//  UIPasteboardTest2
//
//  Created by maqj on 5/13/16.
//  Copyright © 2016 maqj. All rights reserved.
//

#import "ViewController.h"
//#import "EmmLib.h"
//#import <emmlib/emmlib.h>

@interface ViewController ()
- (IBAction)testAction:(id)sender;
- (IBAction)tapAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFeild;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [EmmLib pasteboardHookEnable:YES];
    
//    [_textFeild canPerformAction:(nonnull SEL) withSender:(nullable id)];
    
//    UIPasteboard *paste = [UIPasteboard generalPasteboard];
////    paste.strings = @[@"test"];
//    NSLog(@"%ld", paste.changeCount);
//    [paste setValue:@"string value forKey" forKey:@"string"];
//    [paste setValue:@"string value forKeyPath" forKeyPath:@"string"];
//    [paste setValue:@"string value forPasteboardType" forPasteboardType:@"string"];
//    [paste setValue:@"string value forUndefinedKey" forUndefinedKey:@"string"];
    
//    [paste valueForKey:@"string"];
//    [paste valueForKeyPath:@"string"];
//    [paste valueForUndefinedKey:@"string"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testAction:(id)sender {
    
    UIPasteboard *paster = [UIPasteboard generalPasteboard];
    NSLog(@"%@", paster.string);
}

- (IBAction)tapAction:(id)sender {
    [_textFeild resignFirstResponder];
    [_textView resignFirstResponder];
}
@end
