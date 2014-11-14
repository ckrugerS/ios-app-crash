//
//  BackgroundProcessor.m
//  LoctionLogger
//
//  Created by Cornelis Kruger on 2014/11/14.
//  Copyright (c) 2014 private. All rights reserved.
//

#import "BackgroundProcessor.h"

@implementation BackgroundProcessor

BOOL _shouldKeepRunning;

- (void)runAsync {
    DDLogInfo(@"runAsync");
    [NSThread detachNewThreadSelector:@selector(runAsyncThread) toTarget:self withObject:nil];
}

- (void)runAsyncThread {
    DDLogInfo(@"runAsyncThread");
    @autoreleasepool {
        _shouldKeepRunning = YES;
        @try {
            DDLogInfo(@"running it");
            [self run];
        }
        @catch (NSException *ex) {
            DDLogInfo(@"%@",ex.reason);
        }
    }
}

- (NSDate *)getNextSyncTime {
    
    return [[NSDate date] dateByAddingTimeInterval:1];
}

- (void)run {
    
    if (!_shouldKeepRunning)
        return;
    
    DDLogWarn(@"Sync with timestamp");
    
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(run)
                                   userInfo:nil
                                    repeats:NO];
    
    [[NSRunLoop currentRunLoop] run];
}

@end
