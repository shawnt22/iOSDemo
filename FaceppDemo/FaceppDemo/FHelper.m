//
//  FHelper.m
//  FaceppDemo
//
//  Created by 佳佑 on 14-4-2.
//  Copyright (c) 2014年 shawnt22@gmail.com. All rights reserved.
//

#import "FHelper.h"

@implementation FHelper

+ (UIAlertView *)alertWithTitle:(NSString *)title Message:(NSString *)message Delegate:(id<UIAlertViewDelegate>)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    return alert;
}

@end

@implementation NSData (CMSampleBufferRefConvert)

+ (NSData *)dataFromCMSampleBufferRef:(CMSampleBufferRef)sampleBufferRef
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBufferRef);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    void *src_buff = CVPixelBufferGetBaseAddress(imageBuffer);
    
    NSData *data = [NSData dataWithBytes:src_buff length:bytesPerRow * height];
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    return data;
}

@end
