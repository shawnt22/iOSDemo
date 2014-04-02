//
//  FHelper.h
//  FaceppDemo
//
//  Created by 佳佑 on 14-4-2.
//  Copyright (c) 2014年 shawnt22@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *kFaceppApiKey;
extern NSString *kFaceppApiSecret;

@interface FHelper : NSObject

+ (UIAlertView *)alertWithTitle:(NSString *)title Message:(NSString *)message Delegate:(id<UIAlertViewDelegate>)delegate;

@end

#import <AVFoundation/AVFoundation.h>
@interface NSData (CMSampleBufferRefConvert)

+ (NSData *)dataFromCMSampleBufferRef:(CMSampleBufferRef)sampleBufferRef;

@end