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

CHDeclareClass(NSFileManager)

CHMethod(4, BOOL, NSFileManager, setUbiquitous, BOOL, flag, itemAtURL, NSURL*, url, destinationURL, NSURL*, destinationURL, error, NSError* __unsafe_unretained*, err){
    NSLog(@"####### HOOKED NSFileManager, %s, itemAtURL = %@", __FUNCTION__, url);
    NSLog(@"%@", self);
    
    if(isExcludedFromBackupKey){
        return YES;
    }
    return CHSuper(4, NSFileManager, setUbiquitous, flag, itemAtURL, url, destinationURL, destinationURL, error, err);
}

CHDeclareClass(NSURL)

CHMethod(3, BOOL, NSURL, setResourceValue, id, value, forKey, NSString*, key, error, NSError* __unsafe_unretained*, err){
    
    id curValue = value;
    
    if([key isEqualToString:NSURLIsExcludedFromBackupKey]){
        curValue = @(isExcludedFromBackupKey);
    }
    
    NSLog(@"####### HOOKED NSURL, %s, value = %@", __FUNCTION__, curValue);
    NSLog(@"%@", self);

    return CHSuper(3, NSURL, setResourceValue, curValue, forKey, key, error, err);
}

CHMethod(2, BOOL, NSURL, setResourceValues, NSDictionary*, keyedValues, error,  NSError* __unsafe_unretained*, err){
    
    NSMutableDictionary *mutDic = [keyedValues mutableCopy];
    
    id value = mutDic[NSURLIsExcludedFromBackupKey];
    if (value != nil) {
        mutDic[NSURLIsExcludedFromBackupKey] = @(isExcludedFromBackupKey);
    }
    
    NSLog(@"####### HOOKED NSURL, %s, values = %@", __FUNCTION__, mutDic);

    return CHSuper(2, NSURL, setResourceValues, [mutDic copy], error, err);
}

+ (void)hook{
    CHLoadClass(NSURL);
    
    CHHook(3, NSURL, setResourceValue, forKey, error);
    CHHook(2, NSURL, setResourceValues, error);
    
    CHLoadClass(NSFileManager);
    CHHook(4, NSFileManager, setUbiquitous, itemAtURL, destinationURL, error);
}


+ (BOOL)addNotBackUpiCloud{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSArray *libPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *docPath = [docPaths objectAtIndex:0];
    NSString *libPath = [libPaths objectAtIndex:0];
    
    return [self fileList:docPath] && [self fileList:libPath];
}

/*
  If you have a large number of support files, you may store them in a custom subdirectory and apply the extended attribute to just the directory.
 */
+ (BOOL)fileList:(NSString*)directory{
    
    BOOL isOk = YES;
    
    NSError *error = nil;
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:directory error:&error];
    
    for (NSString* each in fileList) {
        
        NSMutableString* path = [[NSMutableString alloc]initWithString:directory];
        
        [path appendFormat:@"/%@",each];
        NSURL *filePath = [NSURL fileURLWithPath:path];
        
        isOk &= [self addSkipBackupAttributeToItemAtURL:filePath];
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
