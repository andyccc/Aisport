//
//  CTSaveNSlog.m
//  Aisport
//
//  Created by Apple on 2020/12/2.
//

#import "CTSaveNSlog.h"

@implementation CTSaveNSlog

+ (void)redirectNSlogToDocumentFolder
{
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"Simulator"]) {
        return;
    }

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString *documentDirectory = [paths objectAtIndex:0];

    NSString *fileName = [NSString stringWithFormat:@"test.log"];

    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];

    // Delete existing files
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:logFilePath error:nil];

    //Enter the log into the file
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);

}

@end
