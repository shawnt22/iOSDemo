//
//  AppDelegate.h
//  SCategoryControlDemo
//
//  Created by 滕 松 on 12-10-25.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCategoryControl.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, SCategoryControlDataSource>

@property (strong, nonatomic) UIWindow *window;

@end

@interface Category : NSObject

@property (nonatomic, retain) NSString *content;
@property (nonatomic, assign) CGRect itemFrame;

@end

@interface Category(Test)
+ (NSMutableArray *)testCategories;
+ (Category *)randomContentCategory;
@end
