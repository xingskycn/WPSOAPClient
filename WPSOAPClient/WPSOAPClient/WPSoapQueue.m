//
//  WPSoapQueue.m
//  WPHelper
//
//  Created by Peng Leon on 12/9/3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WPSoapQueue.h"

@implementation WPSoapQueue

+(WPSoapQueue *)singleSoapQueue{
    static WPSoapQueue *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WPSoapQueue alloc] init];
        [sharedInstance setMaxConcurrentOperationCount:1];
    });
    return sharedInstance;
}

@end
