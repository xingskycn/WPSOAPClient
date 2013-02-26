//
//  WPXMLWriter.h
//  WPHelper
//
//  Created by Peng Leon on 12/9/7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <libxml/parser.h>

@class WPXMLNode;
@interface WPXMLWriter : NSObject{
    NSString            *_encoding;
    NSString            *_version;
    WPXMLNode           *_rootNode;
    xmlDocPtr           _doc;
}
+(WPXMLWriter *)xmlWriter;//define encoding="UTF-8" version="1.0"
-(id)initWithEncoding:(NSString *)encoding version:(NSString *)version; 
-(void)setEncoding:(NSString *)encoding;

-(void)setRootNodeByName:(NSString *)name;
-(void)setRootNode:(WPXMLNode *)rootNode;
-(WPXMLNode *)rootNode;

-(NSString *)asXML;//dump to memory
-(BOOL)saveXML:(NSString *)filePath;//dump to file

-(void)addChild:(WPXMLNode *)node; //add on root node
-(void)addChild:(WPXMLNode *)node parentNode:(WPXMLNode *)parentNode;//add on appointed node

-(void)addChildWithName:(NSString *)name value:(NSString *)value;//add on root node
-(void)addChildWithName:(NSString *)name value:(NSString *)value parentNode:(WPXMLNode *)parentNode;//add on appointed node

-(void)setDTDWithName:(NSString *)name externalID:(NSString *)extID systemID:(NSString *)sysID;
-(void)setGlobalNameSpace:(NSString *)name value:(NSString *)value;

-(NSString *)dumpNode:(WPXMLNode *)node;
@end
