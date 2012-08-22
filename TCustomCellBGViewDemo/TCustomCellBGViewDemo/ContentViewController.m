//
//  ContentViewController.m
//  TCustomCellBGViewDemo
//
//  Created by 滕 松 on 12-8-22.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentCustomCell.h"

@implementation ContentViewController
@synthesize contentCellType;

+ (NSString *)contentControllerTitleWith:(ContentCustomCellType)cellType {
    NSString *result = @"";
    switch (cellType) {
        case ContentCustomCellPlainSimple:
            result = @"Plain : Simple";
            break;
        case ContentCustomCellPlainInnerDropShadow:
            result = @"Plain : Inner & Drop shadow";
            break;
        case ContentCustomCellGroupSimple:
            result = @"Group : Simple";
            break;
        case ContentCustomCellGroupInnerDropShadow:
            result = @"Group : Inner & Drop shadow";
            break;
        default:
            break;
    }
    return result;
}

- (id)initWithContentCellType:(ContentCustomCellType)ctype {
    self = [super init];
    if (self) {
        self.contentCellType = ctype;
    }
    return self;
}
- (UITableViewStyle)tableStyle {
    return self.contentCellType > ContentCustomCellPlainInnerDropShadow ? UITableViewStyleGrouped : UITableViewStylePlain;
}
- (Class)cellClass {
    Class result = [UITableViewCell class];
    switch (self.contentCellType) {
        case ContentCustomCellPlainSimple:
            result = [ContentPlainSimpleCell class];
            break;
        case ContentCustomCellPlainInnerDropShadow:
            result = [ContentPlainInnerDropShadowCell class];
            break;
        case ContentCustomCellGroupSimple:
            result = [ContentGroupSimpleCell class];
            break;
        case ContentCustomCellGroupInnerDropShadow:
            result = [ContentGroupInnerDropShadowCell class];
            break;
        default:
            break;
    }
    return result;
}

#pragma mark controller delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [ContentViewController contentControllerTitleWith:self.contentCellType];
    
    UITableView *_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height) style:self.tableStyle];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    [_table release];
}

#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *_identifier = @"ccell";
    UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    if (!_cell) {
        Class _cclass = self.cellClass;
        _cell = [[[_cclass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier] autorelease];
        _cell.textLabel.backgroundColor = [UIColor clearColor];
        _cell.textLabel.textColor = [UIColor whiteColor];
        _cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    _cell.textLabel.text = [NSString stringWithFormat:@"row %d", indexPath.row];
    
    if (self.contentCellType > ContentCustomCellPlainInnerDropShadow) {
        ((TCustomCellBGView *)_cell.backgroundView).bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:20];
        ((TCustomCellBGView *)_cell.selectedBackgroundView).bgStyle = [TCustomCellBGView groupStyleWithIndex:indexPath.row Count:20];
    } else {
        ((TCustomCellBGView *)_cell.backgroundView).bgStyle = [TCustomCellBGView plainStyleWithIndex:indexPath.row Count:20];
        ((TCustomCellBGView *)_cell.selectedBackgroundView).bgStyle = [TCustomCellBGView plainStyleWithIndex:indexPath.row Count:20];
    }
    
    return _cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
