//
//  WPXMLWriter.m
//  WPHelper
//
//  Created by Peng Leon on 12/9/7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WPXMLWriter.h"
#include <libxml/tree.h>
#import "NSFileManager+Util.h"
#import "NSString+Path.h"
#import "WPXMLNode.h"

@implementation WPXMLWriter

-(void)dealloc{
    _R(_rootNode);
    _R(_version);
    _R(_encoding);
    xmlFreeDoc(_doc);
    [super dealloc];
}

+(WPXMLWriter *)xmlWriter{
    return [[[WPXMLWriter alloc] initWithEncoding:@"UTF-8" version:@"1.0"] autorelease];
}

-(id)initWithEncoding:(NSString *)encoding version:(NSString *)version{
    self = [super init];
    if (self) {
        _encoding = [encoding retain];
        _version = [version retain];
        _doc = xmlNewDoc(BAD_CAST[_version UTF8String]);
    }
    return self;
}

-(void)setEncoding:(NSString *)encoding{
    _encoding = [encoding retain];
}

-(void)setRootNodeByName:(NSString *)name{
    WPXMLNode *node = [WPXMLNode nodeWithName:name];
    [self setRootNode:node];
}

-(void)setRootNode:(WPXMLNode *)rootNode{
    _rootNode = [rootNode retain];
    xmlDocSetRootElement(_doc,[rootNode getNodePtr]);
}

-(WPXMLNode *)rootNode{
    return _rootNode;
}

-(void)addChildWithName:(NSString *)name value:(NSString *)value{
    [self addChildWithName:name value:value parentNode:_rootNode];
}

-(void)addChildWithName:(NSString *)name value:(NSString *)value parentNode:(WPXMLNode *)parent{
    WPXMLNode *node = [WPXMLNode nodeWithName:name];
    [node setContent:value];
    [self addChild:node parentNode:parent];
}

-(void)addChild:(WPXMLNode *)node{
    [self addChild:node parentNode:_rootNode];
}

-(void)addChild:(WPXMLNode *)node parentNode:(WPXMLNode *)parentNode{
    [parentNode addChild:node];
}

-(void)setDTDWithName:(NSString *)name externalID:(NSString *)extID systemID:(NSString *)sysID{
    xmlCreateIntSubset(_doc, BAD_CAST[name UTF8String], BAD_CAST[extID UTF8String], BAD_CAST[sysID UTF8String]);
}

-(void)setGlobalNameSpace:(NSString *)name value:(NSString *)value{
    xmlNewGlobalNs(_doc, BAD_CAST[value UTF8String], BAD_CAST[name UTF8String]);
}

-(NSString *)asXML{
    xmlChar *buffer;
    int bufferSize;
    xmlDocDumpFormatMemoryEnc(_doc, &buffer, &bufferSize, [_encoding UTF8String], 1);
    if (bufferSize > 0) {
        NSString *xml = [[NSString alloc] initWithCString:(const char *)buffer encoding:NSUTF8StringEncoding];
        xmlFree(buffer);
        return [xml autorelease];
    }
    return nil;
}

-(BOOL)saveXML:(NSString *)filePath{
    int result = xmlSaveFile([filePath UTF8String],_doc);
    if (result == -1) {
        return NO;
    }
    return YES;
}


-(NSString *)dumpNode:(WPXMLNode *)node{
    xmlBufferPtr nodeBuffer = xmlBufferCreate();
    xmlNodeDump(nodeBuffer, _doc, [node getNodePtr], 0, 1);
    const xmlChar *content = xmlBufferContent(nodeBuffer);
    NSString *xml = [[NSString alloc] initWithCString:(const char *)content encoding:NSUTF8StringEncoding];
    xmlBufferFree(nodeBuffer); 
    return [xml autorelease];
}

@end
