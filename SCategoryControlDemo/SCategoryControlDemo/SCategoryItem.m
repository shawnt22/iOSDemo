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
- (void)drawContentWithContext:(CGContextRef)context Rect:(CGRect)rect;
@end
@implementation SCategoryItem (Draw)
- (void)drawBackgroundWithContext:(CGContextRef)context Rect:(CGRect)rect {
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    CGFloat _r = rect.size.height / 2;
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y+rect.size.height/2);
    CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y, rect.origin.x+rect.size.width/2, rect.origin.y, _r);
    CGContextAddArcToPoint(context, rect.origin.x+rect.size.width, rect.origin.y, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height/2, _r);
    CGContextAddArcToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height, rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height, _r);
    CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y+rect.size.height, rect.origin.x, rect.origin.y+rect.size.height/2, _r);
    CGContextClosePath(context);
    
    CGContextFillPath(context);
    
    CGContextRestoreGState(context);
}
- (void)drawContentWithContext:(CGContextRef)context Rect:(CGRect)rect {
    CGContextSaveGState(context);
    
    [[UIColor whiteColor] set];
    
    
    CGContextRestoreGState(context);
}
@end

@implementation SCategoryItem
@synthesize reusableIdentifier, itemIndexPath;
@synthesize bgColor, contentColor, contentFont;

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
    [self drawContentWithContext:context Rect:rect];
}

@end
