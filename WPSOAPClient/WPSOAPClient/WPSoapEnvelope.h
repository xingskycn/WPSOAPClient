//
//  WPSoapEnvelope.h
//  WPHelper
//
//  Created by Peng Leon on 12/9/3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPSoapProtocol.h"

@interface WPSoapEnvelope : NSObject<WPSoapProtocol>{

}
+(WPSoapEnvelope *)soapEnvelope;
@end
