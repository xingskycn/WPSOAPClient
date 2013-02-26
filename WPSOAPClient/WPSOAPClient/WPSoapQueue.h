//
//  WPSoapQueue.h
//  WPHelper
//
//  Created by Peng Leon on 12/9/3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WPThreadQueue.h"

@interface WPSoapQueue : WPThreadQueue{

}
+(WPSoapQueue *)singleSoapQueue;//创建一个每次执行一个thread的queue
@end
