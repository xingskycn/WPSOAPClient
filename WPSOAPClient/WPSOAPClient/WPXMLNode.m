//
//  WPXMLNode.m
//  WPHelper
//
//  Created by Peng Leon on 12/9/7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WPXMLNode.h"
#include <libxml/tree.h>

@interface WPXMLNode()
-(xmlNsPtr)getNameSpaceWithName:(NSString *)name;
@end

@implementation WPXMLNode

-(void)dealloc{
    [super dealloc];
}

+(WPXMLNode *)nodeWithName:(NSString *)name{
    return [[[WPXMLNode alloc] initWithName:name] autorelease];
}

-(id)initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        _node = xmlNewNode(NULL, BAD_CAST[name UTF8String]);
    }
    return self;
}

-(id)initWithNode:(xmlNode *)node{
    self = [super init];
    if (self) {
        _node = node;
    }
    return self;
}

-(NSString *)getName{
    NSString *value = nil;
    const xmlChar *content = _node->name;
    if (content != NULL) {
        value = [[[NSString alloc] initWithCString:(const char *)content encoding:NSUTF8StringEncoding] autorelease];
    }
    return value;
}

-(void)setContent:(NSString *)content{
    if (_node != NULL && content != nil) {
        xmlNodeSetContent(_node, BAD_CAST[content UTF8String]);
    }
}

-(void)addContent:(NSString *)content{
    if (_node != NULL && content != nil) {
        xmlNodeAddContent(_node, BAD_CAST[content UTF8String]);
    } 
}

-(NSString *)getContent{
    NSString *value = nil;
    xmlChar *content = xmlNodeGetContent(_node);
    if (content != NULL) {
        value = [[[NSString alloc] initWithCString:(const char *)content encoding:NSUTF8StringEncoding] autorelease];
    }
    return value;
}

-(void)addAttribute:(NSString *)name value:(NSString *)value{
    if ((_node != NULL) && (name != nil) && (value != nil)) {
        xmlNewProp(_node,BAD_CAST[name UTF8String],BAD_CAST[value UTF8String]);
    }
}

-(void)setAttribute:(NSString *)name value:(NSString *)value{
    if ((_node != NULL) && (name != nil) && (value != nil)) {
        xmlSetProp(_node,BAD_CAST[name UTF8String],BAD_CAST[value UTF8String]);
    }
}

-(void)addAttribute:(NSString *)name value:(NSString *)value forNameSpace:(NSString *)nameSpace{
    xmlNsPtr nsPtr = [self getNameSpaceWithName:nameSpace];
    if (nsPtr != NULL) {
        xmlNewNsProp(_node, nsPtr, BAD_CAST[name UTF8String], BAD_CAST[value UTF8String]);
    }
}

-(NSString *)getAttributeWithName:(NSString *)name{
    NSString *value = nil;
    xmlChar *attr = xmlGetProp(_node, BAD_CAST[name UTF8String]);
    if (attr != NULL) {
        value = [[[NSString alloc] initWithCString:(const char *)attr encoding:NSUTF8StringEncoding] autorelease];
    }
    return value;
}

-(void)setNameSpace:(NSString *)name value:(NSString *)value{
    const char *cValue = (value != nil ? [value UTF8String] : NULL);
    const xmlNsPtr ns =  xmlNewNs(_node, BAD_CAST cValue, BAD_CAST[name UTF8String]);
    if (ns != NULL) {
        xmlSetNs(_node, ns);
    }
}

-(void)addNameSpace:(NSString *)name value:(NSString *)value{
    xmlNewNs(_node, BAD_CAST[value UTF8String], BAD_CAST[name UTF8String]);
}

-(xmlNsPtr)getNameSpaceWithName:(NSString *)name{
    xmlNsPtr ns = xmlSearchNs(NULL, _node, BAD_CAST[name UTF8String]);
    return ns;
}

-(void)addChild:(WPXMLNode *)child{
    xmlNodePtr childNode = [child getNodePtr];
    if (childNode != NULL) {
        xmlAddChild(_node, childNode);
    }
}

-(xmlNodePtr)getNodePtr{
    return _node;
}

-(xmlElementType)getNodeType{
    return _node->type;
}

-(BOOL)hasChild{
    xmlNode *childNode = _node->children;
    if (childNode == NULL) {
        return NO;
    }
    return YES;
}

-(BOOL)isBlankNode{
    return xmlIsBlankNode(_node);
}

-(BOOL)isTextNode{
    return xmlNodeIsText(_node);
}

-(unsigned short)getLineNumber{
    return _node->line;
}

-(WPXMLNode *)getParentNode{
    xmlNode *parentNode = _node->parent; 
    if (parentNode == NULL) {
        return nil;
    }
    WPXMLNode *node = [[[WPXMLNode alloc] initWithNode:parentNode] autorelease];
    return node;
}

-(WPXMLNode *)getChildNode{
    xmlNode *childNode = _node->children;
    if (childNode == NULL) {
        return nil;
    }
    WPXMLNode *node = [[[WPXMLNode alloc] initWithNode:childNode] autorelease];
    return node;
}

-(WPXMLNode *)getLastChildNode{
    xmlNode *lastNode = xmlGetLastChild(_node);
    if (lastNode == NULL) {
        return nil;
    }
    WPXMLNode *node = [[[WPXMLNode alloc] initWithNode:lastNode] autorelease];
    return node;
}

-(WPXMLNode *)getNextNode{
    xmlNode *nextNode = _node->next;
    if (nextNode == NULL) {
        return nil;
    }
    WPXMLNode *node = [[[WPXMLNode alloc] initWithNode:nextNode] autorelease];
    return node;
}

@end
