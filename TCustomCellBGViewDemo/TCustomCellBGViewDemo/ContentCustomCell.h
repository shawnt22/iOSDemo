//
//  ContentCustomCell.h
//  TCustomCellBGViewDemo
//
//  Created by 滕 松 on 12-8-22.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCustomBGCell.h"

#define kCustomCellBGLineColor          [UIColor colorWithRed:25/255.0 green:25/255.0 blue:27/255.0 alpha:1.0]
#define kCustomCellBGFillColor          [UIColor colorWithRed:50/255.0 green:51/255.0 blue:56/255.0 alpha:1.0]
#define kCustomCellBGInnerShadowColor   [UIColor colorWithRed:68/255.0 green:71/255.0 blue:77/255.0 alpha:1.0]
#define kCustomCellSelectedBGLineColor  kCustomCellBGLineColor
#define kCustomCellSelectedBGFillColor  [UIColor colorWithRed:255/255.0 green:72/255.0 blue:0/255.0 alpha:1.0]

@interface ContentPlainSimpleCell : UITableViewCell

@end

@interface ContentPlainInnerDropShadowCell : UITableViewCell

@end

@interface ContentGroupSimpleCell : UITableViewCell

@end

@interface ContentGroupInnerDropShadowCell : UITableViewCell

@end
