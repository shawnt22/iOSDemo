//
//  ContentViewController.h
//  TCustomCellBGViewDemo
//
//  Created by 滕 松 on 12-8-22.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ContentCustomCellPlainSimple,
    ContentCustomCellPlainInnerDropShadow,
    ContentCustomCellGroupSimple,
    ContentCustomCellGroupInnerDropShadow,
    
    ContentCustomCellTypeCount,
}ContentCustomCellType;

@interface ContentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) ContentCustomCellType contentCellType;
@property (nonatomic, readonly) UITableViewStyle tableStyle;
@property (nonatomic, readonly) Class cellClass;

- (id)initWithContentCellType:(ContentCustomCellType)ctype;
+ (NSString *)contentControllerTitleWith:(ContentCustomCellType)cellType;

@end
