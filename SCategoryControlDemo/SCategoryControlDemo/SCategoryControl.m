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
@property (nonatomic, retain) NSMutableDictionary *reusableStorage;
@property (nonatomic, retain) NSMutableArray *activingItems;

- (void)removeItem:(UIView<SCategoryItemProtocol> *)item withIdentifier:(NSString *)identifier fromStorage:(NSMutableDictionary *)storage;
- (void)addItem:(UIView<SCategoryItemProtocol> *)item withIdentifier:(NSString *)identifier toStorage:(NSMutableDictionary *)storage;
- (UIView<SCategoryItemProtocol> *)dequeueItemWithIdentifier:(NSString *)identifier inStorage:(NSMutableDictionary *)storage;
- (void)clearControl;
- (void)check;
- (CGSize)controlContentSize;
- (void)fillFreeFieldWithLeftItem:(UIView<SCategoryItemProtocol> *)leftItem RightItem:(UIView<SCategoryItemProtocol> *)rightItem visiableItems:(NSMutableArray *)items visiableRect:(CGRect)visiableRect;
- (void)appearItem:(UIView<SCategoryItemProtocol> *)item;
- (void)disappearItem:(UIView<SCategoryItemProtocol> *)item;

@end

#pragma mark - Notify
@interface SCategoryControl(Notify)
- (NSInteger)notifyNumberOfColumnInCategoryControl:(SCategoryControl *)categoryControl;
- (CGFloat)notifyCategoryControl:(SCategoryControl *)categoryControl widthAtIndexPath:(SCategoryIndexPath)indexPath;
- (UIView<SCategoryItemProtocol> *)notifyCategoryControl:(SCategoryControl *)categoryControl itemAtIndexPath:(SCategoryIndexPath)indexPath;
@end

@implementation SCategoryControl(Notify)
- (NSInteger)notifyNumberOfColumnInCategoryControl:(SCategoryControl *)categoryControl {
    if (self.controlDataSource && [self.controlDataSource respondsToSelector:@selector(numberOfColumnInCategoryControl:)]) {
        return [self.controlDataSource numberOfColumnInCategoryControl:categoryControl];
    }
    return 0;
}
- (CGFloat)notifyCategoryControl:(SCategoryControl *)categoryControl widthAtIndexPath:(SCategoryIndexPath)indexPath {
    if (self.controlDataSource && [self.controlDataSource respondsToSelector:@selector(categoryControl:widthAtIndexPath:)]) {
        return [self.controlDataSource categoryControl:categoryControl widthAtIndexPath:indexPath];
    }
    return 0.0;
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
@synthesize reusableStorage, activingItems;

#pragma mark init dealloc
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.reusableStorage = [NSMutableDictionary dictionary];
        self.activingItems = [NSMutableArray array];
        
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
    self.reusableStorage = nil;
    self.activingItems = nil;
    
    [super dealloc];
}

#pragma mark item manager
- (UIView<SCategoryItemProtocol> *)dequeueReusableItemWithIdentifier:(NSString *)identifier {
    return [self dequeueItemWithIdentifier:identifier inStorage:self.reusableStorage];
}
- (void)addItem:(UIView<SCategoryItemProtocol> *)item withIdentifier:(NSString *)identifier toStorage:(NSMutableDictionary *)storage {
    if (!item) {
        return;
    }
    NSMutableArray *_items = [storage objectForKey:identifier];
    if (!_items) {
        _items = [NSMutableArray array];
        [storage setObject:_items forKey:identifier];
    }
    [_items addObject:item];
}
- (void)removeItem:(UIView<SCategoryItemProtocol> *)item withIdentifier:(NSString *)identifier fromStorage:(NSMutableDictionary *)storage {
    if (!item) {
        return;
    }
    NSMutableArray *_items = [storage objectForKey:identifier];
    [_items removeObject:item];
}
- (UIView<SCategoryItemProtocol> *)dequeueItemWithIdentifier:(NSString *)identifier inStorage:(NSMutableDictionary *)storage {
    NSMutableArray *_items = [storage objectForKey:identifier];
    if (!_items) {
        _items = [NSMutableArray array];
        [storage setObject:_items forKey:identifier];
    }
    return [_items lastObject];
}
- (void)reloadControl {
    [self clearControl];
    self.controlScrollView.contentSize = [self controlContentSize];
    [self check];
}
- (void)clearControl {
    for (UIView *_item in self.activingItems) {
        [_item removeFromSuperview];
    }
    self.reusableStorage = [NSMutableDictionary dictionary];
    self.activingItems = [NSMutableArray array];
}
- (void)appearItem:(UIView<SCategoryItemProtocol> *)item {
    [self.controlScrollView addSubview:item];
    [self.controlScrollView sendSubviewToBack:item];
    [self.activingItems addObject:item];
    [self removeItem:item withIdentifier:item.reusableIdentifier fromStorage:self.reusableStorage];
}
- (void)disappearItem:(UIView<SCategoryItemProtocol> *)item {
    [self addItem:item withIdentifier:item.reusableIdentifier toStorage:self.reusableStorage];
    if (item.superview) {
        [item removeFromSuperview];
    }
    [self.activingItems removeObject:item];
}

#pragma mark scroll delegae
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self check];
}
- (void)check {
    //  可视区为两屏
    CGFloat _x = self.controlScrollView.contentOffset.x - self.controlScrollView.bounds.size.width/2;
    _x = _x < 0.0 ? 0.0 : _x;
    CGRect _visiableRect = CGRectMake(_x, self.controlScrollView.contentOffset.y, self.controlScrollView.bounds.size.width*2, self.controlScrollView.bounds.size.height);
    UIView<SCategoryItemProtocol> *_leftItem = nil;
    UIView<SCategoryItemProtocol> *_rightItem = nil;
    for (NSInteger _index = 0; _index < [self.activingItems count]; _index++) {
        UIView<SCategoryItemProtocol> *_item = [self.activingItems objectAtIndex:_index];
        CGRect _intersection = CGRectIntersection(_visiableRect, _item.frame);
        //  移除不在当前屏内的item
        if (CGRectIsEmpty(_intersection)) {
            [self disappearItem:_item];
            _index--;
            continue;
        }
        //  找到最左侧item
        if (_leftItem == nil) {
            _leftItem = _item;
        } else {
            _leftItem = _leftItem.frame.origin.x < _item.frame.origin.x ? _leftItem : _item;
        }
        //  找到最右侧item
        if (_rightItem == nil) {
            _rightItem = _item;
        } else {
            _rightItem = _rightItem.frame.origin.x+_rightItem.frame.size.width > _item.frame.size.width+_item.frame.origin.x ? _rightItem : _item;
        }
    }
    [self fillFreeFieldWithLeftItem:_leftItem RightItem:_rightItem visiableItems:self.activingItems visiableRect:_visiableRect];
}
//  每列递归填充空白区域
- (void)fillFreeFieldWithLeftItem:(UIView<SCategoryItemProtocol> *)leftItem RightItem:(UIView<SCategoryItemProtocol> *)rightItem visiableItems:(NSMutableArray *)items visiableRect:(CGRect)visiableRect {
    BOOL _needRecall = NO;
    //  区域尚无item，直接添加第一个
    if (!leftItem && !rightItem) {
        UIView<SCategoryItemProtocol> *_item = [self notifyCategoryControl:self itemAtIndexPath:SCategoryIndexPathMake(0)];
        if (_item) {
            [self appearItem:_item];
            leftItem = _item;
            rightItem = _item;
            _needRecall = YES;
        }
    }
    //  若左方未填满，则在左方添加一个item
    if (leftItem && leftItem.frame.origin.x > visiableRect.origin.x) {
        UIView<SCategoryItemProtocol> *_item = [self notifyCategoryControl:self itemAtIndexPath:SCategoryIndexPathMake(leftItem.itemIndexPath.column-1)];
        if (_item) {
            [self appearItem:_item];
            leftItem = _item;
            _needRecall = YES;
        }
    }
    //  若右方未填满，则在右方添加一个item
    if (rightItem && rightItem.frame.origin.x+rightItem.frame.size.width < visiableRect.origin.x+visiableRect.size.width) {
        UIView<SCategoryItemProtocol> *_item = [self notifyCategoryControl:self itemAtIndexPath:SCategoryIndexPathMake(rightItem.itemIndexPath.column+1)];
        if (_item) {
            [self appearItem:_item];
            rightItem = _item;
            _needRecall = YES;
        }
    }
    if (_needRecall) {
        [self fillFreeFieldWithLeftItem:leftItem RightItem:rightItem visiableItems:items visiableRect:visiableRect];
    }
}
- (CGSize)controlContentSize {
    CGFloat _width = self.bounds.size.width;
    NSInteger _number = [self notifyNumberOfColumnInCategoryControl:self];
    for (NSInteger _column = 0; _column < _number; _column++) {
        _width += [self notifyCategoryControl:self widthAtIndexPath:SCategoryIndexPathMake(_column)];
    }
    return CGSizeMake(_width, self.bounds.size.height);
}

@end
