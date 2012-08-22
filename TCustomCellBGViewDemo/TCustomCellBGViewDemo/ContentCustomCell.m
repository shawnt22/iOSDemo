//
//  ContentCustomCell.m
//  TCustomCellBGViewDemo
//
//  Created by 滕 松 on 12-8-22.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import "ContentCustomCell.h"

@implementation ContentPlainSimpleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        TCustomCellBGView *_bg = [[TCustomCellBGView alloc] initWithFrame:CGRectZero];
        _bg.lineColor = kCustomCellBGLineColor;
        _bg.fillColor = kCustomCellBGFillColor;
        self.backgroundView = _bg;
        [_bg release];
        
        TCustomCellBGView *_sbg = [[TCustomCellBGView alloc] initWithFrame:CGRectZero];
        _sbg.lineColor = kCustomCellSelectedBGLineColor;
        _sbg.fillColor = kCustomCellSelectedBGFillColor;
        self.selectedBackgroundView = _sbg;
        [_sbg release];
    }
    return self;
}

@end

@implementation ContentPlainInnerDropShadowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        TCustomCellBGView *_bg = [[TCustomCellBGView alloc] initWithFrame:CGRectZero];
        _bg.lineColor = kCustomCellBGLineColor;
        _bg.fillColor = kCustomCellBGFillColor;
        _bg.innerShadowColor = kCustomCellBGInnerShadowColor;
        _bg.innerShadowWidth = 1.0;
        self.backgroundView = _bg;
        [_bg release];
        
        TCustomCellBGView *_sbg = [[TCustomCellBGView alloc] initWithFrame:CGRectZero];
        _sbg.lineColor = kCustomCellSelectedBGLineColor;
        _sbg.fillColor = kCustomCellSelectedBGFillColor;
        self.selectedBackgroundView = _sbg;
        [_sbg release];
    }
    return self;
}

@end

@implementation ContentGroupSimpleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        TCustomCellBGView *_bg = [[TCustomCellBGView alloc] initWithFrame:CGRectZero];
        _bg.lineColor = kCustomCellBGLineColor;
        _bg.fillColor = kCustomCellBGFillColor;
        self.backgroundView = _bg;
        [_bg release];
        
        TCustomCellBGView *_sbg = [[TCustomCellBGView alloc] initWithFrame:CGRectZero];
        _sbg.lineColor = kCustomCellSelectedBGLineColor;
        _sbg.fillColor = kCustomCellSelectedBGFillColor;
        self.selectedBackgroundView = _sbg;
        [_sbg release];
    }
    return self;
}

@end

@implementation ContentGroupInnerDropShadowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        TCustomCellBGView *_bg = [[TCustomCellBGView alloc] initWithFrame:CGRectZero];
        _bg.lineColor = kCustomCellBGLineColor;
        _bg.fillColor = kCustomCellBGFillColor;
        _bg.innerShadowColor = kCustomCellBGInnerShadowColor;
        _bg.innerShadowWidth = 1.0;
        self.backgroundView = _bg;
        [_bg release];
        
        TCustomCellBGView *_sbg = [[TCustomCellBGView alloc] initWithFrame:CGRectZero];
        _sbg.lineColor = kCustomCellSelectedBGLineColor;
        _sbg.fillColor = kCustomCellSelectedBGFillColor;
        self.selectedBackgroundView = _sbg;
        [_sbg release];
    }
    return self;
}

@end