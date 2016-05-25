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
    BOOL is = [EmmLib icloudSyncEnable:NO];
    
//    [self icloudSyncTest];
    
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
    
    
    
    //write.
//    BOOL ret = [@"fucking the icloud." writeToFile:testFilePath atomically:NO encoding:NSUTF8StringEncoding error:&error];
//    if (!ret) {
//        NSLog(@"%@", error);
//    }

   // [self icloudSyncTest];
    //1464158216.282999
    
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *filePath = [path stringByAppendingPathComponent:@"1464158216.282999"];
//    
//    NSURL *testUrl = [NSURL fileURLWithPath:filePath];
//    id value;
//    BOOL ret = [testUrl getResourceValue:&value forKey:NSURLIsExcludedFromBackupKey error:&error];
//    NSLog(@"%@", value);
//    ret = [testUrl getResourceValue:&value forKey:NSURLIsUbiquitousItemKey error:&error];
//    
//    ///--
//    NSFileManager *fileMgr = [NSFileManager defaultManager];
//    NSURL *uUrl = [fileMgr URLForUbiquityContainerIdentifier:@"iCloud.com.maqj.UIPasteboardTest1s"];
//    NSURL *urlTest = [NSURL URLWithString:[testUrl lastPathComponent] relativeToURL:uUrl];
//    
//    ret = [fileMgr setUbiquitous:YES itemAtURL:testUrl destinationURL:urlTest error:&error];
//    if (!ret) {
//        NSLog(@"%@", error);
//    }
//    
//    ret = [testUrl getResourceValue:&value forKey:NSURLIsUbiquitousItemKey error:&error];
//
//    NSLog(@"is ubiquitous: %ld", [value integerValue]);
}

- (void)icloudSyncTest{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSError *error;

        NSFileManager *fileMgr = [NSFileManager defaultManager];
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *testFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%f", [NSDate date].timeIntervalSince1970]];
        BOOL ret = [@"fucking the icloud." writeToFile:testFilePath atomically:NO encoding:NSUTF8StringEncoding error:&error];
        if (!ret) {
            NSLog(@"%@", error);
        }
        
//        BOOL is = [EmmLib icloudSyncEnable:YES];
        
        NSURL *documentUrl = [NSURL fileURLWithPath:testFilePath];

        id value;
        ret = [documentUrl getResourceValue:&value forKey:NSURLIsUbiquitousItemKey error:&error];
        
        NSLog(@"is ubiquitous1: %ld", [value integerValue]);

        
        NSString *testStr = [NSString stringWithContentsOfURL:documentUrl encoding:NSUTF8StringEncoding error:&error];

        NSURL *uUrl = [fileMgr URLForUbiquityContainerIdentifier:@"iCloud.com.maqj.UIPasteboardTest1s"];
        NSURL *urlTest = [NSURL URLWithString:[testFilePath lastPathComponent] relativeToURL:uUrl];
        
        ret = [fileMgr setUbiquitous:YES itemAtURL:documentUrl destinationURL:urlTest error:&error];
        if (!ret) {
            NSLog(@"%@", error);
        }
        
        [NSThread sleepForTimeInterval:5];
        
        ret = [documentUrl getResourceValue:&value forKey:NSURLIsUbiquitousItemKey error:&error];
        
        
        NSLog(@"is ubiquitous2: %ld", [value integerValue]);

        [self readTest];

    });
}

- (void)readTest{
    
    NSError *error;
    //read.
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSURL *uUrl = [fileMgr URLForUbiquityContainerIdentifier:@"iCloud.com.maqj.UIPasteboardTest1s"];
    
    NSArray *files = [fileMgr contentsOfDirectoryAtURL:uUrl includingPropertiesForKeys:nil options:0 error:&error];
    
    NSLog(@"%@", files);
    
    
    [files enumerateObjectsUsingBlock:^(NSURL * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isDir = NO;
        if ([fileMgr fileExistsAtPath:uUrl.path isDirectory:&isDir] && isDir) {
            NSError *error;
            NSArray *dFiles = [fileMgr contentsOfDirectoryAtURL:obj includingPropertiesForKeys:nil options:0 error:&error];
            
            NSLog(@"%@", dFiles);
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
