//
//  FHelper.h
//  FaceppDemo
//
//  Created by 佳佑 on 14-4-2.
//  Copyright (c) 2014年 shawnt22@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHelper : NSObject

@end

#import <AVFoundation/AVFoundation.h>
@interface NSData (CMSampleBufferRefConvert)

+ (NSData *)dataFromCMSampleBufferRef:(CMSampleBufferRef)sampleBufferRef;

@end