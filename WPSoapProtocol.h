//
//  WPSoapProtocol.h
//  WPHelper
//
//  Created by Peng Leon on 12/9/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDefineSOAPGlobalPrefix @"SOAP-ENV"

@class WPXMLNode;

@protocol WPSoapProtocol <NSObject>
@required
-(WPXMLNode *)getNode;
@end
