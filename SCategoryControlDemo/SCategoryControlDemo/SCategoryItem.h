//
//  SCategoryItem.h
//  SCategoryControlDemo
//
//  Created by 滕 松 on 12-10-25.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    NSInteger column;
}SCategoryIndexPath;

NS_INLINE SCategoryIndexPath SCategoryIndexPathMake(NSInteger _column) {
    SCategoryIndexPath indexPath;
    indexPath.column = _column;
    return indexPath;
}

@protocol SCategoryItemProtocol <NSObject>
@property (nonatomic, retain) NSString *reusableIdentifier;
@optional
@property (nonatomic, assign) SCategoryIndexPath itemIndexPath;
@end

@interface SCategoryItem : UIView<SCategoryItemProtocol>
@property (nonatomic, retain) UIColor *bgColor;
@property (nonatomic, retain) UIColor *contentColor;
@property (nonatomic, retain) UIFont *contentFont;

- (id)initWithFrame:(CGRect)frame ReusableIdentifier:(NSString *)reusableIdentifier;

@end
