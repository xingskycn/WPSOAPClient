//
//  WPSoapBody.m
//  WPHelper
//
//  Created by Peng Leon on 12/9/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WPSoapBody.h"
#import "WPXMLNode.h"

@implementation WPSoapBody

+(WPSoapBody *)soapBody{
    return [[[WPSoapBody alloc] init] autorelease];
}

-(WPXMLNode *)getNode{
    NSString *name = [NSString stringWithFormat:@"%@:Body", kDefineSOAPGlobalPrefix];
    WPXMLNode *bodyNode = [WPXMLNode nodeWithName:name];
    return bodyNode;
}

@end
