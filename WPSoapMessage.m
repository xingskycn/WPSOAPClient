//
//  WPSoapPart.m
//  WPHelper
//
//  Created by Peng Leon on 12/9/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WPSoapMessage.h"
#import "WPXMLNode.h"
#import "WPSoapParam.h"

@implementation WPSoapMessage


+(WPSoapMessage *)messageWithName:(NSString *)name{
    return [[[WPSoapMessage alloc] initWithName:name] autorelease];
}

-(void)dealloc{
    _R(_params);
    _R(_node);
    _R(_name);
    [super dealloc];
}

-(id)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        _name = [name retain];
        _node = [[WPXMLNode alloc] initWithName:_name];
        _params = [[NSMutableArray alloc] init];
    }
    return self;
}

-(WPXMLNode *)getNode{
    return _node;
}

-(void)setNameSpace:(NSString *)name value:(NSString *)value{
    [_node setNameSpace:name value:value];
}

-(void)addParam:(WPSoapParam *)param{
    if (param != nil) {
        WPXMLNode *paramNode = [param getNode];
        if (paramNode != nil) {
            [_node addChild:paramNode];
            [_params addObject:param];
        }
    }
}

-(NSArray *)getAllParams{
    return [NSArray arrayWithArray:_params];
}

@end
