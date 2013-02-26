//
//  WPSoapEnvelope.m
//  WPHelper
//
//  Created by Peng Leon on 12/9/3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WPSoapEnvelope.h"
#import "WPXMLNode.h"

@implementation WPSoapEnvelope

-(void)dealloc{
    [super dealloc];
}

+(WPSoapEnvelope *)soapEnvelope{
    return [[[WPSoapEnvelope alloc] init] autorelease];
    }
    
    
-(WPXMLNode *)getNode{
    NSString *name = [NSString stringWithFormat:@"%@:Envelope", kDefineSOAPGlobalPrefix];
    WPXMLNode *envelopeNode = [WPXMLNode nodeWithName:name];
    [envelopeNode addNameSpace:kDefineSOAPGlobalPrefix value:@"http://schemas.xmlsoap.org/soap/envelope/"];
    [envelopeNode addAttribute:@"encodingStyle" value:@"http://schemas.xmlsoap.org/soap/encoding/" forNameSpace:kDefineSOAPGlobalPrefix];
    [envelopeNode addNameSpace:@"xsd" value:@"http://www.w3.org/2001/XMLSchema"];
    [envelopeNode addNameSpace:@"xsi" value:@"http://www.w3.org/2001/XMLSchema-instance"];    
    [envelopeNode addNameSpace:@"SOAP-ENC" value:@"http://schemas.xmlsoap.org/soap/encoding/"]; 
    return envelopeNode;
        }
    



@end
