//
//  WPXMLReader.h
//  WPHelper
//
//  Created by Peng Leon on 12/9/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <libxml/parser.h>


/*
 *因为此类是基于DOM方式，比较点用内存，所以只适用于小型的XML解析
 *如果需要解析大型的XML文件，请使用NSXMLParser
 */
@class WPXMLNode;
@interface WPXMLReader : NSObject{
    NSString            *_encoding;
    WPXMLNode           *_rootNode;
    xmlDocPtr           _doc;
}

+(WPXMLReader *)xmlReader;
-(id)initWithEncoding:(NSString *)encoding;

-(void)setEncoding:(NSString *)encoding;

-(BOOL)readFile:(NSString *)filePath;
-(BOOL)readXML:(NSString *)xmlString;

-(WPXMLNode *)rootNode;//根结点
-(void)enumerateNodesUsingBlock:(void (^)(WPXMLNode *node, BOOL *stop))block;//遍历所有节点
-(NSString *)dumpNode:(WPXMLNode *)node;
@end
