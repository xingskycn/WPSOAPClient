//
//  WPXMLNode.h
//  WPHelper
//
//  Created by Peng Leon on 12/9/7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <libxml/parser.h>

@interface WPXMLNode : NSObject{
    xmlNodePtr      _node;
}
+(WPXMLNode *)nodeWithName:(NSString *)name;
-(id)initWithName:(NSString *)name;
-(id)initWithNode:(xmlNode *)node;

-(void)addChild:(WPXMLNode *)child;

-(NSString *)getName;

-(void)setContent:(NSString *)content;
-(void)addContent:(NSString *)content;
-(NSString *)getContent;

-(void)setNameSpace:(NSString *)name value:(NSString *)value;
-(void)addNameSpace:(NSString *)name value:(NSString *)value;
-(void)addAttribute:(NSString *)name value:(NSString *)value forNameSpace:(NSString *)nameSpace;

-(void)addAttribute:(NSString *)name value:(NSString *)value;
-(void)setAttribute:(NSString *)name value:(NSString *)value;
-(NSString *)getAttributeWithName:(NSString *)name;

-(xmlNodePtr)getNodePtr;
-(xmlElementType)getNodeType;

-(BOOL)hasChild;
-(BOOL)isBlankNode;
-(BOOL)isTextNode;

-(unsigned short)getLineNumber;//行数

-(WPXMLNode *)getParentNode;//得到父结点
-(WPXMLNode *)getChildNode; //指向第一个子结点
-(WPXMLNode *)getLastChildNode;//指向最后一个子结点
-(WPXMLNode *)getNextNode;//当前的下一个结点
@end
