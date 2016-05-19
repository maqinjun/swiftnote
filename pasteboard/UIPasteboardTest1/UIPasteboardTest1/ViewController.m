//
//  ViewController.m
//  UIPasteboardTest1
//
//  Created by maqj on 5/13/16.
//  Copyright © 2016 maqj. All rights reserved.
//

#import "ViewController.h"
#import <emmlib/emmlib.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [UIPasteboardHook hook];
    [EmmLib pasteboardHookEnable:YES];
    
//    NSLog(@"%@", UIPasteboardNameGeneral);
//    NSLog(@"%@", UIPasteboardNameFind);
//    
//    UIPasteboard *paster = [UIPasteboard generalPasteboard];
//    paster.string = @"string to test2";
//
//    paster.image = [UIImage imageNamed:@"test.png"];
    
//    UIPasteboard *generalPaster = [UIPasteboard generalPasteboard];
//
//    UIPasteboard *paster = [UIPasteboard pasteboardWithUniqueName];
//    paster.URL = [NSURL URLWithString:@"www.baidu.com"];
//    NSLog(@"%@, %d, %d", paster.URL, paster.persistent, generalPaster.persistent);
//    
//    generalPaster.persistent = YES;
    
//    [EmmLib icloudSyncEnable:YES];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *document = paths[0];
    NSString *document = [[NSBundle mainBundle] resourcePath];
    NSError *error = nil;
    NSURL *url = [NSURL URLWithString:@"."];
    BOOL success = [url setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:&error];
    
    if (!success) {
        NSLog(@"%@", error);
    }
//    return success;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
