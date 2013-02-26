//
//  WPSoapPart.h
//  WPHelper
//
//  Created by Peng Leon on 12/9/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPSoapProtocol.h"

@class WPXMLNode;
@class WPSoapParam;
@interface WPSoapMessage : NSObject<WPSoapProtocol>{
    NSString            *_name;
    WPXMLNode           *_node;
    NSMutableArray      *_params;
}

+(WPSoapMessage *)messageWithName:(NSString *)name;
-(id)initWithName:(NSString *)name;

-(void)setNameSpace:(NSString *)name value:(NSString *)value;
-(void)addParam:(WPSoapParam *)param;
-(NSArray *)getAllParams;
@end
