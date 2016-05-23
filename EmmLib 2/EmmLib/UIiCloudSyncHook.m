//
//  UIiCloudSyncHook.m
//  EmmLib
//
//  Created by maqj on 5/20/16.
//  Copyright © 2016 uusafe. All rights reserved.
//

#import "UIiCloudSyncHook.h"
#import "CaptainHook/CaptainHook.h"

typedef  NSError* __unsafe_unretained* NSErrorPointer;


@implementation UIiCloudSyncHook

BOOL isExcludedFromBackupKey = YES;

CHDeclareClass(NSURL)


CHMethod(3, BOOL, NSURL, setResourceValue, id, value, forKey, NSString*, key, error, NSError* __unsafe_unretained*, err){
    NSLog(@"####### HOOKED NSURL, %s", __FUNCTION__);
    NSLog(@"%@", self);
    
    id curValue = value;
    
    if([key isEqualToString:NSURLIsExcludedFromBackupKey]){
        curValue = @(isExcludedFromBackupKey);
    }
    
    return CHSuper(3, NSURL, setResourceValue, curValue, forKey, key, error, err);
}

CHMethod(2, BOOL, NSURL, setResourceValues, NSDictionary*, keyedValues, error,  NSError* __unsafe_unretained*, err){
    NSLog(@"####### HOOKED NSURL, %s", __FUNCTION__);
    
    NSMutableDictionary *mutDic = [keyedValues mutableCopy];
    
    id value = mutDic[NSURLIsExcludedFromBackupKey];
    if (value != nil) {
        mutDic[NSURLIsExcludedFromBackupKey] = @(isExcludedFromBackupKey);
    }
    return CHSuper(2, NSURL, setResourceValues, [mutDic copy], error, err);
}

+ (void)hook{
    CHLoadClass(NSURL);
    
    CHHook(3, NSURL, setResourceValue, forKey, error);
    CHHook(2, NSURL, setResourceValues, error);
}


+ (BOOL)addNotBackUpiCloud{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *libPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *docPath = [docPaths objectAtIndex:0];
    NSString *libPath = [libPaths objectAtIndex:0];
    
    return [self fileList:docPath] && [self fileList:libPath];
}


+ (BOOL)fileList:(NSString*)directory{
    
    BOOL isOk = YES;
    
    NSError *error = nil;
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:directory error:&error];
    
    for (NSString* each in fileList) {
        
        NSMutableString* path = [[NSMutableString alloc]initWithString:directory];
        
        [path appendFormat:@"/%@",each];
        NSURL *filePath = [NSURL fileURLWithPath:path];
        
        if ([path rangeOfString:@"com.apple.dataaccess.launchd"].length <= 0) {
            isOk &= [self addSkipBackupAttributeToItemAtURL:filePath];
        }
        
        isOk &= [self fileList:path];
    }
    
    return isOk;
}



//设置禁止云同步

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL{
    
    NSError *error = nil;
    
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: isExcludedFromBackupKey]
                    
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    
    if(!success){
        
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        
    }
    
    return success;
}

@end
