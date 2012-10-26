//
//  SCategoryItem.h
//  SCategoryControlDemo
//
//  Created by 滕 松 on 12-10-25.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCategoryItemProtocol <NSObject>
@property (nonatomic, retain) NSString *reusableIdentifier;
@optional

@end

@interface SCategoryItem : UIView

@end
