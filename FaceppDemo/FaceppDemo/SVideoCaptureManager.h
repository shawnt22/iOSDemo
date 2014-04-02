//
//  SVideoCaptureManager.h
//  FaceppDemo
//
//  Created by 佳佑 on 14-4-1.
//  Copyright (c) 2014年 shawnt22@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@interface SVideoCaptureManager : NSObject
@property (nonatomic, readonly) AVCaptureSession *session;

- (AVCaptureVideoPreviewLayer *)videoPreviewLayerWithDevicePosition:(AVCaptureDevicePosition)position;
- (BOOL)setVideoDataOutputSampleBufferDelegate:(id<AVCaptureVideoDataOutputSampleBufferDelegate>)delegate;  //  do not call before videoPreviewLayerWithDevicePosition:

@end
