//
//  FDetectViewController.m
//  FaceppDemo
//
//  Created by 佳佑 on 14-4-1.
//  Copyright (c) 2014年 shawnt22@gmail.com. All rights reserved.
//

#import "FDetectViewController.h"
#import "FaceppAPI.h"

@interface FDetectViewController ()

@end

@implementation FDetectViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.videoCaptureManager.supportedOutput = SVideoCaptureManagerStillImageOutput;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *takePicture = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    takePicture.frame = CGRectMake(ceilf((self.view.bounds.size.width-100)/2), 300, 100, 44);
    takePicture.backgroundColor = [UIColor greenColor];
    [takePicture addTarget:self action:@selector(takePictureAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takePicture];
}
- (void)takePictureAction:(id)sender
{
    AVCaptureConnection *connection = [self.videoCaptureManager.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    
    [self.videoCaptureManager.stillImageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error){
        if (!error) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            FaceppResult *result = [[FaceppAPI detection] detectWithURL:nil orImageData:imageData mode:FaceppDetectionModeNormal attribute:FaceppDetectionAttributeRace|FaceppDetectionAttributeSmiling];
            [FHelper alertWithTitle:(result.success ? @"Success" : @"Fail") Message:[NSString stringWithFormat:@"%@", result.content] Delegate:nil];
            
        }
    }];
}

@end
