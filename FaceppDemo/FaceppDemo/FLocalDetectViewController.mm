//
//  FLocalDetectViewController.m
//  FaceppDemo
//
//  Created by 佳佑 on 14-4-1.
//  Copyright (c) 2014年 shawnt22@gmail.com. All rights reserved.
//

#import "FLocalDetectViewController.h"
#import "FaceppLocalDetector.h"

#pragma mark - LocalFace

@interface FaceppLocalResult (Description)
- (NSString *)resultDescription;
@end

@implementation FaceppLocalResult (Description)

- (NSString *)resultDescription
{
    NSMutableString *desc = [NSMutableString string];
    [desc appendString:@"FACES {\n"];
    for (FaceppLocalFace *face in self.faces) {
        [desc appendFormat:@"%d : %@\n", face.trackingID, NSStringFromCGRect(face.bounds)];
    }
    [desc appendString:@"}"];
    return desc;
}

@end

#pragma mark - LocalDetect

@implementation FLocalDetectViewController

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
    takePicture.backgroundColor = [UIColor blueColor];
    [takePicture addTarget:self action:@selector(takePictureAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:takePicture];
}
- (void)takePictureAction:(id)sender
{
    NSLog(@"****** Take Picture Begin ******");
    AVCaptureConnection *connection = [self.videoCaptureManager.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    
    [self.videoCaptureManager.stillImageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error){
        NSLog(@"****** Take Picture End ******");
        if (!error) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            
            NSDictionary *options = @{FaceppDetectorTracking : @(NO),
                                      FaceppDetectorMinFaceSize : @(20),
                                      FaceppDetectorAccuracy : FaceppDetectorAccuracyHigh};
            FaceppLocalDetector *localDetector = [FaceppLocalDetector detectorOfOptions:options andAPIKey:kFaceppApiKey];
            NSLog(@"****** Local Detector Begin ******");
            FaceppLocalResult *localResult = [localDetector detectWithImage:[UIImage imageWithData:imageData scale:1.0]];
            [FHelper alertWithTitle:nil Message:[localResult resultDescription] Delegate:nil];
            NSLog(@"****** Local Detector End ******");
        }
    }];
}

@end
