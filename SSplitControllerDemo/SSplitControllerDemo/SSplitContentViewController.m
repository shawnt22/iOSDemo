//
//  SSplitContentViewController.m
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import "SSplitContentViewController.h"
#import "AppDelegate.h"

@implementation SSplitContentViewController
@synthesize splitNavigationController;

#pragma mark init & dealloc
- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)dealloc {
    [super dealloc];
}

#pragma mark split controller protocol
- (UINavigationController<SSplitControllerProtocol> *)splitNavigationController {
    return [SSplitContentUtil splitNavigationControllerWithSplitViewController:self];
}

#pragma mark controller delegate
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [AppDelegate shareSplitRootViewController].contentSplitEnable = YES;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [AppDelegate shareSplitRootViewController].contentSplitEnable = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    TestTableView *_table = [[TestTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _table.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_table];
    [_table release];
    
    UIBarButtonItem *_push = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(pushAction:)];
    self.navigationItem.rightBarButtonItem = _push;
    [_push release];
}

- (void)pushAction:(id)sender {
    UIViewController *controller = [[UIViewController alloc] init];
    controller.title = @"push controller";
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

@end

@implementation SSplitNavigationContentViewController

- (UIViewController<SSplitControllerProtocol> *)splitViewController {
    return [SSplitContentUtil splitViewControllerWithSplitNavigationController:self];
}

@end


#pragma mark - tset views

@implementation TestTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *_identifier = @"cell";
    UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    if (!_cell) {
        _cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier] autorelease];
    }
    _cell.textLabel.text = [NSString stringWithFormat:@"row %d", indexPath.row];
    return _cell;
}

@end

