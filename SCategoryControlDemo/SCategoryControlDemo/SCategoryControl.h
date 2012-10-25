//
//  SCategoryControl.h
//  SCategoryControlDemo
//
//  Created by 滕 松 on 12-10-25.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCategoryItem.h"

typedef struct {
    NSInteger column;
}SCategoryIndexPath;

NS_INLINE SCategoryIndexPath SCategoryIndexPathMake(NSInteger _column) {
    SCategoryIndexPath indexPath;
    indexPath.column = _column;
    return indexPath;
}

@class SCategoryControl;
@protocol SCategoryControlDataSource <NSObject>
@required
- (NSInteger)numberOfColumnInCategoryControl:(SCategoryControl *)categoryControl;
- (UIView<SCategoryItemProtocol> *)categoryControl:(SCategoryControl *)categoryControl itemAtIndexPath:(SCategoryIndexPath)indexPath;
@end

@protocol SCategoryControlDelegate <NSObject>
@optional

@end

@interface SCategoryControl : UIView <UIScrollViewDelegate>
@property (nonatomic, assign) id<SCategoryControlDataSource> controlDataSource;
@property (nonatomic, assign) id<SCategoryControlDelegate> controlDelegate;

- (UIView<SCategoryItemProtocol> *)dequeueReusableItemWithIdentifier:(NSString *)identifier;

@end
