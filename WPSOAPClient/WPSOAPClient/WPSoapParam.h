//
//  WPSoapParam.h
//  WPHelper
//
//  Created by Peng Leon on 12/9/3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPSoapProtocol.h"

typedef enum _TYPE_CODE{
    TYPE_CODE_BOOL,
    TYPE_CODE_INT,
    TYPE_CODE_INT32,
    TYPE_CODE_INT64,
    TYPE_CODE_FLOAT,
    TYPE_CODE_DOUBLE,
    TYPE_CODE_STRING,
    TYPE_CODE_ARRAY,
    TYPE_CODE_MAP
}TypeCode;


@class WPXMLNode;
@interface WPSoapParam : NSObject<WPSoapProtocol>{
    TypeCode    _typeCode;
    id          _value;
    NSString    *_key;
}
@property(retain, nonatomic)NSString    *key;

+(WPSoapParam *)paramWithValue:(id)value key:(NSString *)key typeCode:(TypeCode)typeCode;



@end
