//
//  WPSoapRequest.m
//  WPHelper
//
//  Created by Peng Leon on 12/9/3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WPSoapRequest.h"
#import "WPSoapParam.h"
#import "WPSoapBody.h"
#import "WPSoapMessage.h"
#import "WPSoapEnvelope.h"
#import "WPHttpRequest.h"
#import "WPXMLNode.h"
#import "WPXMLWriter.h"
#import "WPException.h"

@interface WPSoapRequest()
-(NSString *)buildXMLMessage;
@end

@implementation WPSoapRequest

-(void)dealloc{
    _R(_location);
    _R(_error);
    _R(_result);
    _R(_soapRequest);
    _R(_soapAction);
    _R(_soapMessages);
    [super dealloc];
}

+(WPSoapRequest *)requestWithLocation:(NSString *)location{
    WPSoapRequest *request = [[WPSoapRequest alloc] init];
    [request setLocation:location];
    return [request autorelease];
}

+(WPSoapRequest *)request{
    WPSoapRequest *request = [[WPSoapRequest alloc] init];
    return [request autorelease];
}

-(id)init{
    self = [super init];
    if (self) {
        _soapMessages = [[NSMutableArray alloc] init];
    }
    return self;
}


-(BOOL)execute{
    BOOL isOK = NO;
    if (_location == nil) {
        @throw [WPException exceptionWithObject:self reason:@"location is nil..."];
        return isOK;
}
    _soapRequest = [[WPHttpRequest alloc] initWithURL:[NSURL URLWithString:_location]];
    if (_soapRequest == nil) {
        @throw [WPException exceptionWithObject:self reason:@"can not init the request..."];
        return isOK;
}
    if ([_soapMessages count] == 0) {
        @throw [WPException exceptionWithObject:self reason:@"SOAP messages is empty..."];
        return isOK;
    }
    NSString *xmlMessage = [self buildXMLMessage];
    if (xmlMessage == nil) {
        return isOK;
    }
    NSString *msgLength = [NSString stringWithFormat:@"%d", [xmlMessage length]];
    [_soapRequest addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [_soapRequest addRequestHeader:@"SOAPAction" value:_soapAction];
    [_soapRequest addRequestHeader:@"Content-Length" value:msgLength];
	[_soapRequest setRequestMethod:METHOD_POST];
    [_soapRequest appendPostData:[xmlMessage dataUsingEncoding:NSUTF8StringEncoding]];
    ITLog(@"request headers : %@", [_soapRequest requestHeaders]);
    [_soapRequest startSynchronous];
    _error = [[_soapRequest error] retain];
    _result = [[_soapRequest responseData] retain];
    if ((_error == nil) && (_result != nil)) {
        isOK = YES;
    }
    return isOK;
}

-(NSString *)buildXMLMessage{
    NSString *xml = nil;
    WPXMLWriter *writer = [WPXMLWriter xmlWriter];
    
    WPSoapEnvelope *envelope = [WPSoapEnvelope soapEnvelope];
    WPXMLNode *envelopeNode = [envelope getNode];
    ITLog(@"envelop -> %@", [writer dumpNode:envelopeNode]);
    [writer setRootNode:envelopeNode];
    
    WPSoapBody  *body = [WPSoapBody soapBody];
    WPXMLNode *bodyNode = [body getNode];
    ITLog(@"body -> %@", [writer dumpNode:bodyNode]);
    
    for (int i=0; i<[_soapMessages count]; i++) {
        WPSoapMessage *message = [_soapMessages objectAtIndex:i];
        WPXMLNode  *messageNode = [message getNode];
        ITLog(@"message -> %@", [writer dumpNode:messageNode]);
        if (messageNode != nil) {
            [bodyNode addChild:messageNode];
        }
    }
    [envelopeNode addChild:bodyNode];
    xml = [writer asXML];
    return xml;
}


-(NSData *)getResult{
    return _result;
}

-(NSString *)getReturn{
    NSString *ret = nil;
    NSData *result = [self getResult];
    NSString *theXML = [[[NSString alloc] initWithBytes:[result bytes] length:[result length] encoding:NSUTF8StringEncoding] autorelease];
    NSString *regExStr = @"<return xsi:type=\"xsd:string\">(.+?)</return>";
    NSError *error = nil;
    NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:regExStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    if (error != nil) {
        return ret;
    }
    NSTextCheckingResult *checkingResult = [regEx firstMatchInString:theXML
                                                             options:0
                                                               range:NSMakeRange(0, [theXML length])];
    
    if ([checkingResult numberOfRanges] != 2) {
        return ret;
    }
    ret = [theXML substringWithRange:[checkingResult rangeAtIndex:1]];
    return ret;
}

-(NSError *)getError{
    return _error;
}


-(NSString *)getLocation{
    return _location;
}

-(WPHttpRequest *)getHttpRequest{
    return _soapRequest;
}

-(void)setLocation:(NSString *)location{
    _location = [location retain];
}

-(void)setSoapAction:(NSString *)soapAction{
    _soapAction = [soapAction retain];
}

-(void)addSoapMessage:(WPSoapMessage *)soapMessage{
    if (soapMessage != nil) {
        [_soapMessages addObject:soapMessage];
    }
}

-(void)clearSoapMessages{
    [_soapMessages removeAllObjects];
}

@end
