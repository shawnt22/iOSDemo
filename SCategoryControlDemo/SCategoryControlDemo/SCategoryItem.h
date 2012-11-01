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

#define kCategoryItemDefaultHeight 30.0
@interface SCategoryItem : UIView<SCategoryItemProtocol>
@property (nonatomic, retain) UIColor *bgColor;
@property (nonatomic, retain) UIColor *innerShadowColor;
@property (nonatomic, assign) CGFloat innerShadowHeight;
@property (nonatomic, retain) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, retain) UIColor *contentColor;
@property (nonatomic, retain) UIFont *contentFont;
@property (nonatomic, retain) NSString *content;

- (SCategoryItem *)defaultItemWithReusableIdentifier:(NSString *)reusableIdentifier;
- (id)initWithFrame:(CGRect)frame ReusableIdentifier:(NSString *)reusableIdentifier;

- (void)refreshItemWithContent:(NSString *)content Frame:(CGRect)frame;

@end
