//
//  SCategoryControl.m
//  SCategoryControlDemo
//
//  Created by 滕 松 on 12-10-25.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import "SCategoryControl.h"

@interface SCategoryControl()
@property (nonatomic, assign) UIScrollView *controlScrollView;
@property (nonatomic, retain) NSMutableDictionary *reusableItems;
@property (nonatomic, retain) NSMutableDictionary *activingItems;

@end

#pragma mark - Notify
@interface SCategoryControl(Notify)
- (NSInteger)notifyNumberOfColumnInCategoryControl:(SCategoryControl *)categoryControl;
- (UIView<SCategoryItemProtocol> *)notifyCategoryControl:(SCategoryControl *)categoryControl itemAtIndexPath:(SCategoryIndexPath)indexPath;
@end

@implementation SCategoryControl(Notify)
- (NSInteger)notifyNumberOfColumnInCategoryControl:(SCategoryControl *)categoryControl {
    if (self.controlDataSource && [self.controlDataSource respondsToSelector:@selector(numberOfColumnInCategoryControl:)]) {
        return [self.controlDataSource numberOfColumnInCategoryControl:categoryControl];
    }
    return 0;
}
- (UIView<SCategoryItemProtocol> *)notifyCategoryControl:(SCategoryControl *)categoryControl itemAtIndexPath:(SCategoryIndexPath)indexPath {
    if (self.controlDataSource && [self.controlDataSource respondsToSelector:@selector(categoryControl:itemAtIndexPath:)]) {
        return [self.controlDataSource categoryControl:categoryControl itemAtIndexPath:indexPath];
    }
    return nil;
}
@end

#pragma mark - Control
@implementation SCategoryControl
@synthesize controlScrollView;
@synthesize controlDataSource, controlDelegate;
@synthesize reusableItems, activingItems;

#pragma mark init dealloc
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.reusableItems = [NSMutableDictionary dictionary];
        self.activingItems = [NSMutableDictionary dictionary];
        
        UIScrollView *_scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scroll.backgroundColor = self.backgroundColor;
        _scroll.delegate = self;
        [self addSubview:_scroll];
        self.controlScrollView = _scroll;
        [_scroll release];
    }
    return self;
}
- (void)dealloc {
    self.reusableItems = nil;
    self.activingItems = nil;
    
    [super dealloc];
}

#pragma mark item manager
- (UIView<SCategoryItemProtocol> *)dequeueReusableItemWithIdentifier:(NSString *)identifier {
    UIView<SCategoryItemProtocol> *_item = nil;
    
    _item = [[self.reusableItems objectForKey:identifier] lastObject];
    if (_item) {
        
    }
    
    return _item;
}

#pragma mark scroll delegae
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

@end
