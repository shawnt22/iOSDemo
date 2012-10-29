//
//  SCategoryItem.m
//  SCategoryControlDemo
//
//  Created by 滕 松 on 12-10-25.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import "SCategoryItem.h"

@interface SCategoryItem (Draw)
- (void)drawBackgroundWithContext:(CGContextRef)context Rect:(CGRect)rect;
@end
@implementation SCategoryItem (Draw)
- (void)drawBackgroundWithContext:(CGContextRef)context Rect:(CGRect)rect {
    CGContextSaveGState(context);
    
    
    
    CGContextRestoreGState(context);
}
@end

@implementation SCategoryItem
@synthesize reusableIdentifier, itemIndexPath;

- (id)initWithFrame:(CGRect)frame ReusableIdentifier:(NSString *)rIdentifier {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
        self.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        self.reusableIdentifier = rIdentifier;
    }
    return self;
}
- (void)dealloc {
    self.reusableIdentifier = nil;
    [super dealloc];
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    [self drawBackgroundWithContext:context Rect:rect];
}

@end
