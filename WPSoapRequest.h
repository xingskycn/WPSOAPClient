//
//  WPSoapRequest.h
//  WPHelper
//
//  Created by Peng Leon on 12/9/3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WPSoapEnvelope;
@class WPSoapBody;
@class WPHttpRequest;
@class WPSoapMessage;
@interface WPSoapRequest : NSObject{
    NSMutableArray       *_soapMessages;
    NSString             *_location;
    NSString             *_soapAction;
    WPHttpRequest        *_soapRequest;
    NSError              *_error;
    NSData               *_result;
}
+(WPSoapRequest *)requestWithLocation:(NSString *)location;
+(WPSoapRequest *)request;

-(void)setLocation:(NSString *)location;
-(void)setSoapAction:(NSString *)soapAction;
-(void)addSoapMessage:(WPSoapMessage *)soapMessage;

-(BOOL)execute;
-(NSData *)getResult;
-(NSString *)getReturn;
-(NSError *)getError;
-(NSString *)getLocation;
-(WPHttpRequest *)getHttpRequest;
-(void)clearSoapMessages;
@end
