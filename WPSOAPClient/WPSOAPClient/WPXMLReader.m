//
//  WPXMLReader.m
//  WPHelper
//
//  Created by Peng Leon on 12/9/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WPXMLReader.h"
#include <libxml/tree.h>
#import "NSFileManager+Util.h"
#import "NSString+Path.h"
#import "WPXMLNode.h"

typedef void(^NodesEnumerateBlock)(WPXMLNode *node, BOOL *stop);

@interface WPXMLReader()
@property(assign) NodesEnumerateBlock block;
-(void)enumerateNodesWithParentNode:(WPXMLNode *)parentNode stop:(BOOL *)stop;
@end


@implementation WPXMLReader
@synthesize block;

-(void)dealloc{
    _R(_rootNode);
    _R(_encoding);
    xmlFreeDoc(_doc);
    [super dealloc];
}

+(WPXMLReader *)xmlReader{
    return [[[WPXMLReader alloc] initWithEncoding:@"UTF-8"] autorelease];
}

-(id)initWithEncoding:(NSString *)encoding{
    self = [super init];
    if (self) {
        _encoding = [encoding retain];
    }
    return self;
}

-(void)setEncoding:(NSString *)encoding{
    _encoding = [encoding retain];
}

-(BOOL)readFile:(NSString *)filePath{
    _doc = xmlParseFile([filePath UTF8String]);
    if (_doc == NULL) {
        return NO;
    }
    return YES;
}

-(BOOL)readXML:(NSString *)xmlString{
    _doc = xmlParseMemory([xmlString UTF8String], [xmlString length]);
    if (_doc == NULL) {
        return NO;
    }
    return YES;
}

-(WPXMLNode *)rootNode{
    if (_rootNode == nil) {
        xmlNodePtr rootNode = xmlDocGetRootElement(_doc);
        _rootNode = [[WPXMLNode alloc] initWithNode:rootNode];
    }
    return _rootNode;
}

-(void)enumerateNodesUsingBlock:(void (^)(WPXMLNode *node, BOOL *stop))theBlock{
    self.block = theBlock;
    BOOL stop = NO;
    [self enumerateNodesWithParentNode:[self rootNode] stop:&stop];
}

-(void)enumerateNodesWithParentNode:(WPXMLNode *)parentNode stop:(BOOL *)stop{
    if (*stop == YES) {
        return;
    }
    WPXMLNode *currentNode = parentNode;
    while (currentNode != nil) {
        self.block(currentNode, stop);
        if ([currentNode hasChild]) {
            WPXMLNode *childNode = [currentNode getChildNode];
            if (childNode != nil) {
                [self enumerateNodesWithParentNode:childNode stop:stop];
            }
        }
        currentNode = [currentNode getNextNode];
    }
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
