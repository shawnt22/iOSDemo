//
//  RootViewController.m
//  TCustomCellBGViewDemo
//
//  Created by 滕 松 on 12-8-22.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import "RootViewController.h"
#import "ContentViewController.h"

@implementation RootViewController

#pragma mark controller delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Style";
    
    UITableView *_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.bounds.size.height) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    [_table release];
}

#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ContentCustomCellTypeCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *_identifier = @"cell";
    UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    if (!_cell) {
        _cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier] autorelease];
        _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    _cell.textLabel.text = [ContentViewController contentControllerTitleWith:indexPath.row];
    return _cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ContentViewController *_content = [[ContentViewController alloc] initWithContentCellType:indexPath.row];
    [self.navigationController pushViewController:_content animated:YES];
    [_content release];
}

@end
