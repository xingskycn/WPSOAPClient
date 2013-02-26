//
//  WPSoapParam.m
//  WPHelper
//
//  Created by Peng Leon on 12/9/3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WPSoapParam.h"
#import "WPXMLNode.h"

@interface WPSoapParam()
-(NSString*)typeNameForTypeCode:(TypeCode)typeCode;
-(id)initWithValue:(id)value key:(NSString *)key typeCode:(TypeCode)typeCode;
-(NSString *)paramToXML;
@end

@implementation WPSoapParam
@synthesize key = _key;

+(WPSoapParam *)paramWithValue:(id)value key:(NSString *)key typeCode:(TypeCode)typeCode{
    return [[[WPSoapParam alloc] initWithValue:value key:key typeCode:typeCode] autorelease];
}

-(void)dealloc{
    _R(_value);
    _R(_key);
    [super dealloc];
}

-(id)initWithValue:(id)value key:(NSString *)key typeCode:(TypeCode)typeCode{
    self = [super init];
    if (self) {
        _value = [value retain];
        if (key != nil) {
            _key = [key retain];
        }else{
            _key = nil;
        }        
        _typeCode = typeCode;
    }
    return self;
}

-(NSString*)typeNameForTypeCode:(TypeCode)typeCode{
	switch (typeCode) {
		case TYPE_CODE_BOOL:
			return @"xsd:boolean";
		case TYPE_CODE_INT:
			return @"xsd:int";
		case TYPE_CODE_INT32:
			return @"xsd:int32";
		case TYPE_CODE_INT64:
			return @"xsd:int64";
		case TYPE_CODE_FLOAT:
			return @"xsd:float";
		case TYPE_CODE_DOUBLE:
			return @"xsd:double";
		case TYPE_CODE_STRING:
            return @"xsd:string";
        case TYPE_CODE_ARRAY:
            return @"ns2:Vector";
        case TYPE_CODE_MAP:
            return @"ns2:Map";
		default:
			return nil;
	}
}

-(WPXMLNode *)getNode{
    WPXMLNode *node = nil;
    if (_value == nil || _key == nil) {
        return node;
    }
    NSString *type = [self typeNameForTypeCode:_typeCode];
    if (type == nil) {
        return node;
    }
    switch (_typeCode) {
        case TYPE_CODE_BOOL:{
            if (![_value isKindOfClass:[NSNumber class]]) {
                return node;
            }
            BOOL boolValue = [(NSNumber *)_value boolValue];
            NSString *boolValueString = boolValue?@"true":@"false";
            node = [WPXMLNode nodeWithName:_key];
            [node addAttribute:@"xsi:type" value:type];
            [node setContent:boolValueString];
        }break;
            
        case TYPE_CODE_INT:
        case TYPE_CODE_INT32:
        case TYPE_CODE_INT64:
        case TYPE_CODE_FLOAT:
        case TYPE_CODE_DOUBLE:{
            if (![_value isKindOfClass:[NSNumber class]]) {
                return node;
            }
            NSString *stringValue = [(NSNumber *)_value stringValue];
            node = [WPXMLNode nodeWithName:_key];
            [node addAttribute:@"xsi:type" value:type];
            [node setContent:stringValue];
        }break;

        case TYPE_CODE_STRING:{
            if (![_value isKindOfClass:[NSString class]]) {
                return node;
            }
            node = [WPXMLNode nodeWithName:_key];
            [node addAttribute:@"xsi:type" value:type];
            [node setContent:_value];

        }break;
            
        case TYPE_CODE_ARRAY:{
            if (![_value isKindOfClass:[NSArray class]]) {
                return node;
            }
            node = [WPXMLNode nodeWithName:_key];
            for (int i=0; i<[_value count]; i++) {
                NSString *value = [_value objectAtIndex:i];
                WPXMLNode *subNode = [WPXMLNode nodeWithName:@"string"];
                [subNode addAttribute:@"xsi:type" value:@"xsd:string"];
                [subNode setContent:value];
                [node addChild:subNode];
            }
        }break;
            
        case TYPE_CODE_MAP:{
            if (![_value isKindOfClass:[NSDictionary class]]) {
                return node;
            }
            node = [WPXMLNode nodeWithName:_key];
            NSDictionary *tmpValue = (NSDictionary *)_value;
            NSArray *allKeys = [tmpValue allKeys];
            for (int i=0; i<[allKeys count]; i++) {
                NSString *key = [allKeys objectAtIndex:i];
                NSString *value = [tmpValue objectForKey:key];
                WPXMLNode *subNode = [WPXMLNode nodeWithName:key];
                [subNode addAttribute:@"xsi:type" value:@"xsd:string"];
                [subNode setContent:value];
                [node addChild:subNode];
            }
        }break;            
    }
    return node;
}


-(NSString *)paramToXML{
    NSString *nodeDescription = nil;
    if (_value == nil) {
        return nodeDescription;
    }
    NSString *type = [self typeNameForTypeCode:_typeCode];
    if (type == nil) {
        return nodeDescription;
    }
    switch (_typeCode) {
        case TYPE_CODE_BOOL:{
            if (![_value isKindOfClass:[NSNumber class]]) {
                return nodeDescription;
            }
            BOOL boolValue = [(NSNumber *)_value boolValue];
            NSString *boolValueString = boolValue?@"true":@"false";
                nodeDescription = [NSString stringWithFormat:@"<%@ xsi:type=\"%@\">%@</%@>", _key, type, boolValueString, _key];
        }break;
        case TYPE_CODE_INT:{
            if (![_value isKindOfClass:[NSNumber class]]) {
                return nodeDescription;
            }
            int intValue = [(NSNumber *)_value intValue];
                nodeDescription = [NSString stringWithFormat:@"<%@ xsi:type=\"%@\">%d</%@>", _key, type, intValue, _key];
            
        }break;
        case TYPE_CODE_INT32:{
            if (![_value isKindOfClass:[NSNumber class]]) {
                return nodeDescription;
            }
            int32_t int32Value = [(NSNumber *)_value unsignedLongValue];
            nodeDescription = [NSString stringWithFormat:@"<%@ xsi:type=\"%@\">%u</%@>", _key, type, int32Value, _key];
            
        }break;
        case TYPE_CODE_INT64:{
            if (![_value isKindOfClass:[NSNumber class]]) {
                return nodeDescription;
            }
            int64_t int64Value = [(NSNumber *)_value unsignedLongLongValue];
                nodeDescription = [NSString stringWithFormat:@"<%@ xsi:type=\"%@\">%llu</%@>", _key, type, int64Value, _key];
            
        }break;
        case TYPE_CODE_FLOAT:
        case TYPE_CODE_DOUBLE:{
            if (![_value isKindOfClass:[NSNumber class]]) {
                return nodeDescription;
            }
            float floatValue = [(NSNumber *)_value floatValue];
                nodeDescription = [NSString stringWithFormat:@"<%@ xsi:type=\"%@\">%f</%@>", _key, type, floatValue, _key];
            
        }break;
        case TYPE_CODE_STRING:{
            NSString *description = [_value description];
            if (description != nil) {
                    nodeDescription = [NSString stringWithFormat:@"<%@ xsi:type=\"%@\">%@</%@>", _key, type, description, _key];
                }
        }break;
            
        case TYPE_CODE_ARRAY:{
            if (![_value isKindOfClass:[NSArray class]]) {
                return nodeDescription;
            }
            NSMutableString *tmpString = [NSMutableString string];
            NSArray *tmpValue = (NSArray *)_value;
            [tmpString appendFormat:@"<%@ xmlns:ns2=\"http://xml.apache.org/xml-soap\" xsi:type=\"%@\">", _key, type];
            for (int i=0; i<[tmpValue count]; i++) {
                NSString *value = [tmpValue objectAtIndex:i];
                [tmpString appendFormat:@"<item xsi:type=\"xsd:string\">%@</item>", value];
            }
            [tmpString appendFormat:@"</%@>", _key];
            nodeDescription = [NSString stringWithString:tmpString];
        
        }break;
            
        case TYPE_CODE_MAP:{
            if (![_value isKindOfClass:[NSDictionary class]]) {
                return nodeDescription;
            }
            NSMutableString *tmpString = [NSMutableString string];
            NSDictionary *tmpValue = (NSDictionary *)_value;
   
            [tmpString appendFormat:@"<%@ xmlns:ns2=\"http://xml.apache.org/xml-soap\" xsi:type=\"%@\">", _key, type];
            NSArray *allKeys = [tmpValue allKeys];
            for (int i=0; i<[allKeys count]; i++) {
                NSString *key = [allKeys objectAtIndex:i];
                NSString *value = [tmpValue objectForKey:key];
                [tmpString appendString:@"<item>"];
                [tmpString appendFormat:@"<key xsi:type=\"xsd:string\">%@</key>", key];
                [tmpString appendFormat:@"<value xsi:type=\"xsd:string\">%@</value>", value];
                [tmpString appendString:@"</item>"];
            }
            [tmpString appendFormat:@"</%@>", _key];
            nodeDescription = [NSString stringWithString:tmpString];
        
        }break;            
            
            
    }
    return nodeDescription;
}

@end
