//
//  SSplitContentViewController.m
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import "SSplitContentViewController.h"

@interface SSplitContentViewController()
@property (nonatomic, readonly) UIView<SSplitContentViewProtocol> *splitContentView;
@property (nonatomic, assign) TestTableView *testTable;
@end
@implementation SSplitContentViewController
@synthesize beginGesture, moveGesture, isSplitOpenning, splitEnable, splitControllerDelegate;
@synthesize testTable;
@synthesize splitContentView;

#pragma mark init & dealloc
- (id)init {
    self = [super init];
    if (self) {
        self.splitControllerDelegate = nil;
        self.splitEnable = YES;
    }
    return self;
}
- (void)dealloc {
    [super dealloc];
}

#pragma mark split controller protocol
- (UIView<SSplitContentViewProtocol> *)splitContentView {
    if ([self.view conformsToProtocol:@protocol(SSplitContentViewProtocol)]) {
        return (UIView<SSplitContentViewProtocol> *)self.view;
    }
    return nil;
}
- (UIGestureRecognizer *)beginGesture {
    return self.splitContentView.beginGesture;
}
- (UIGestureRecognizer *)moveGesture {
    return self.splitContentView.moveGesture;
}
- (UINavigationController<SSplitControllerProtocol> *)splitNavigationController {
    return [SSplitContentUtil splitNavigationControllerWithSplitController:self];
}

#pragma mark controller delegate
- (void)loadView {
    [super loadView];
    
    TestView *_v = [[TestView alloc] initWithFrame:self.view.frame];
    _v.backgroundColor = self.view.backgroundColor;
    _v.autoresizingMask = self.view.autoresizingMask;
    _v.splitDelegate = self;
    self.view = _v;
    [_v release];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    //  view
//    TestView *_v = [[TestView alloc] initWithFrame:self.view.bounds];
//    _v.backgroundColor = self.view.backgroundColor;
//    _v.splitDelegate = self;
//    [self.view addSubview:_v];
//    [_v release];
    
//    //  table
//    TestTableView *_table = [[TestTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    _table.backgroundColor = self.view.backgroundColor;
//    _table.splitDelegate = self;
//    [self.view addSubview:_table];
//    self.testTable = _table;
//    [_table release];
    
    TestTableView2 *_table = [[TestTableView2 alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _table.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_table];
    [_table release];

//    //  webview
//    TestWebView *_web = [[TestWebView alloc] initWithFrame:self.view.bounds];
//    _web.backgroundColor = self.view.backgroundColor;
//    _web.splitDelegate = self;
//    [self.view addSubview:_web];
//    [_web release];
//    
//    //  scrolview
//    TestScrolView *_scrol = [[TestScrolView alloc] initWithFrame:self.view.bounds];
//    _scrol.backgroundColor = self.view.backgroundColor;
//    _scrol.splitDelegate = self;
//    [self.view addSubview:_scrol];
//    [_scrol release];
}

#pragma mark split delegate
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView beginedGesture:(UIGestureRecognizer *)gesture {
    if (!self.splitEnable) {
        return;
    }
    if (self.splitControllerDelegate && [self.splitControllerDelegate respondsToSelector:@selector(splitController:beginedGesutre:)]) {
        [self.splitControllerDelegate splitController:self beginedGesutre:gesture];
    }
}
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView endedGesture:(UIGestureRecognizer *)gesture {
    if (!self.splitEnable) {
        return;
    }
    if (self.splitControllerDelegate && [self.splitControllerDelegate respondsToSelector:@selector(splitController:endedGesutre:)]) {
        [self.splitControllerDelegate splitController:self endedGesutre:gesture];
    }
}
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView changedGesture:(UIGestureRecognizer *)gesture {
    if (!self.splitEnable) {
        return;
    }
    if (self.splitControllerDelegate && [self.splitControllerDelegate respondsToSelector:@selector(splitController:changedGesutre:)]) {
        [self.splitControllerDelegate splitController:self changedGesutre:gesture];
    }
}
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView canceledGesture:(UIGestureRecognizer *)gesture {
    if (!self.splitEnable) {
        return;
    }
    if (self.splitControllerDelegate && [self.splitControllerDelegate respondsToSelector:@selector(splitController:canceledGesutre:)]) {
        [self.splitControllerDelegate splitController:self canceledGesutre:gesture];
    }
}

@end


@implementation SSplitNavigationContentViewController
@synthesize beginGesture, moveGesture, isSplitOpenning;

- (UIViewController<SSplitContentViewDelegate, SSplitControllerProtocol> *)splitRootViewController {
    if ([self.viewControllers count] > 0) {
        UIViewController *_root = [self.viewControllers objectAtIndex:0];
        if ([_root conformsToProtocol:@protocol(SSplitControllerProtocol)] && [_root conformsToProtocol:@protocol(SSplitContentViewDelegate)]) {
            return (UIViewController<SSplitContentViewDelegate, SSplitControllerProtocol> *)_root;
        }
    }
    return nil;
}
- (UIGestureRecognizer *)beginGesture {
    return self.splitRootViewController.beginGesture;
}
- (UIGestureRecognizer *)moveGesture {
    return self.splitRootViewController.moveGesture;
}
- (id<SSPlitControllerDelegate>)splitControllerDelegate {
    return self.splitRootViewController.splitControllerDelegate;
}
- (void)setSplitControllerDelegate:(id<SSPlitControllerDelegate>)asplitControllerDelegate {
    self.splitRootViewController.splitControllerDelegate = asplitControllerDelegate;
}
- (void)setIsSplitOpenning:(BOOL)aisSplitOpenning {
    self.splitRootViewController.isSplitOpenning = aisSplitOpenning;
}
- (BOOL)isSplitOpenning {
    return self.splitRootViewController.isSplitOpenning;
}
- (void)setSplitEnable:(BOOL)asplitEnable {
    self.splitRootViewController.splitEnable = asplitEnable;
}
- (BOOL)splitEnable {
    return self.splitRootViewController.splitEnable;
}

@end


#pragma mark - tset views

@implementation TestView
@synthesize splitDelegate, beginGesture, moveGesture;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.beginGesture = nil;
        self.moveGesture = nil;
        
        [self addGestures];
    }
    return self;
}
- (void)dealloc {
    self.beginGesture = nil;
    self.moveGesture = nil;
    [super dealloc];
}

- (void)addGestures {
    [SSplitContentUtil addGesturesWithContent:self];
}
- (void)responseGesture:(UIGestureRecognizer *)gesture {
    [SSplitContentUtil responseGesture:gesture Content:self];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [SSplitContentUtil gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer Content:self];
}

@end


@implementation TestTableView
@synthesize splitDelegate, beginGesture, moveGesture;
@synthesize shouldSplit;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.shouldSplit = YES;
        
        self.delegate = self;
        self.dataSource = self;
        
        self.beginGesture = nil;
        self.moveGesture = nil;
        
        //[self addGestures];
    }
    return self;
}
- (void)dealloc {
    self.beginGesture = nil;
    self.moveGesture = nil;
    [super dealloc];
}

- (void)addGestures {
    [SSplitContentUtil addGesturesWithContent:self];
}
- (void)responseGesture:(UIGestureRecognizer *)gesture {
    [SSplitContentUtil responseGesture:gesture Content:self];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [SSplitContentUtil gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer Content:self];
}
- (BOOL)shouldSplitWithSplitContentView:(id<SSplitContentViewProtocol>)splitContentView {
    return self.shouldSplit;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"did scroll");
    self.shouldSplit = NO;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"end dragging : %d", decelerate);
    if (!decelerate) {
        self.shouldSplit = YES;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"end decelerate");
    self.shouldSplit = YES;
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

@implementation TestWebView
@synthesize splitDelegate, beginGesture, moveGesture;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.beginGesture = nil;
        self.moveGesture = nil;
        
        [self addGestures];
    }
    return self;
}
- (void)dealloc {
    self.beginGesture = nil;
    self.moveGesture = nil;
    [super dealloc];
}

- (void)addGestures {
    [SSplitContentUtil addGesturesWithContent:self];
}
- (void)responseGesture:(UIGestureRecognizer *)gesture {
    [SSplitContentUtil responseGesture:gesture Content:self];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [SSplitContentUtil gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer Content:self];
}

@end

@implementation TestScrolView
@synthesize splitDelegate, beginGesture, moveGesture;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.beginGesture = nil;
        self.moveGesture = nil;
        
        [self addGestures];
        
        self.contentSize = CGSizeMake(self.bounds.size.width*2, self.bounds.size.height*2);
    }
    return self;
}
- (void)dealloc {
    self.beginGesture = nil;
    self.moveGesture = nil;
    [super dealloc];
}

- (void)addGestures {
    [SSplitContentUtil addGesturesWithContent:self];
}
- (void)responseGesture:(UIGestureRecognizer *)gesture {
    [SSplitContentUtil responseGesture:gesture Content:self];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [SSplitContentUtil gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer Content:self];
}

@end

@implementation TestTableView2
@synthesize splitContentViewController;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"did scroll");
    self.splitContentViewController.splitEnable = NO;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"end dragging : %d", decelerate);
    if (!decelerate) {
        self.splitContentViewController.splitEnable = YES;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"end decelerate");
    self.splitContentViewController.splitEnable = YES;
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

