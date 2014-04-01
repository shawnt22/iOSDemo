//
//  RootViewController.m
//  FaceppDemo
//
//  Created by 佳佑 on 14-4-1.
//  Copyright (c) 2014年 shawnt22@gmail.com. All rights reserved.
//

#import "RootViewController.h"

enum {
    RootTableRowDetect = 0,
    RootTableRowLocalDetect,
    RootTableRowCount,
};

extern NSString *kDispatchMapTitle;
extern NSString *kDispatchMapController;

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *dispatchMap;
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Root";
    
    self.dispatchMap = @{
                         @(RootTableRowDetect) : @{kDispatchMapTitle : @"Detect", kDispatchMapController : @"FDetectViewController"},
                         @(RootTableRowLocalDetect) : @{kDispatchMapTitle : @"LocalDetect", kDispatchMapController : @"FLocalDetectViewController"}
                         };
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    self.tableView = table;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return RootTableRowCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.dispatchMap[@(indexPath.row)][kDispatchMapTitle];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *controllerName = self.dispatchMap[@(indexPath.row)][kDispatchMapController];
    Class controllerClass = NSClassFromString(controllerName);
    UIViewController *controller = [[controllerClass alloc] init];
    controller.title = self.dispatchMap[@(indexPath.row)][kDispatchMapTitle];
    [self.navigationController pushViewController:controller animated:YES];
}

@end

const NSString *kDispatchMapTitle = @"title";
const NSString *kDispatchMapController = @"action";

@implementation RootNavigationController

- (BOOL)shouldAutorotate
{
    return NO;
}

@end