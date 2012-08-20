//
//  SSplitContentViewController.m
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import "SSplitContentViewController.h"

@interface SSplitContentViewController()
@property (nonatomic, assign) TestTableView *testTable;
@end
@implementation SSplitContentViewController
@synthesize splitControllerDelegate, beginGesture, moveGesture, isSplitOpenning;
@synthesize testTable;

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
- (UIGestureRecognizer *)beginGesture {
    return self.testTable.beginGesture;
}
- (UIGestureRecognizer *)moveGesture {
    return self.testTable.moveGesture;
}
- (UINavigationController<SSplitControllerProtocol> *)splitNavigationController {
    return [SSplitContentUtil splitNavigationControllerWithSplitController:self];
}

#pragma mark controller delegate
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
    TestTableView *_table = [[TestTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _table.backgroundColor = self.view.backgroundColor;
    _table.splitDelegate = self;
    [self.view addSubview:_table];
    self.testTable = _table;
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
    if (self.splitControllerDelegate && [self.splitControllerDelegate respondsToSelector:@selector(splitController:beginedGesutre:)]) {
        [self.splitControllerDelegate splitController:self beginedGesutre:gesture];
    }
}
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView endedGesture:(UIGestureRecognizer *)gesture {
    if (self.splitControllerDelegate && [self.splitControllerDelegate respondsToSelector:@selector(splitController:beginedGesutre:)]) {
        [self.splitControllerDelegate splitController:self beginedGesutre:gesture];
    }
    
    if ([splitContentView isKindOfClass:[UITableView class]]) {
        UITableView *_table = (UITableView *)splitContentView;
        _table.scrollEnabled = YES;
    }
}
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView changedGesture:(UIGestureRecognizer *)gesture {
    if (self.splitControllerDelegate && [self.splitControllerDelegate respondsToSelector:@selector(splitController:beginedGesutre:)]) {
        [self.splitControllerDelegate splitController:self beginedGesutre:gesture];
    }
    if ([splitContentView isKindOfClass:[UITableView class]]) {
        UITableView *_table = (UITableView *)splitContentView;
        _table.scrollEnabled = NO;
    }
}
- (void)splitContentView:(id<SSplitContentViewProtocol>)splitContentView canceledGesture:(UIGestureRecognizer *)gesture {
    if (self.splitControllerDelegate && [self.splitControllerDelegate respondsToSelector:@selector(splitController:beginedGesutre:)]) {
        [self.splitControllerDelegate splitController:self beginedGesutre:gesture];
    }
    if ([splitContentView isKindOfClass:[UITableView class]]) {
        UITableView *_table = (UITableView *)splitContentView;
        _table.scrollEnabled = YES;
    }
}

@end


@implementation SSplitNavigationContentViewController
@synthesize splitControllerDelegate, beginGesture, moveGesture, isSplitOpenning;

- (UIViewController<SSplitContentViewDelegate, SSplitControllerProtocol> *)splitRootViewController {
    if ([self.viewControllers count] > 0) {
        UIViewController *_root = [self.viewControllers objectAtIndex:0];
        if ([_root conformsToProtocol:@protocol(SSplitControllerProtocol)] && [_root conformsToProtocol:@protocol(SSplitContentViewDelegate)]) {
            return (UIViewController<SSplitContentViewDelegate, SSplitControllerProtocol> *)_root;
        }
    }
    return nil;
}
- (void)setSplitControllerDelegate:(id<SSPlitControllerDelegate>)asplitControllerDelegate {
    self.splitRootViewController.splitControllerDelegate = asplitControllerDelegate;
}
- (id<SSPlitControllerDelegate>)splitControllerDelegate {
    return self.splitRootViewController.splitControllerDelegate;
}
- (UIGestureRecognizer *)beginGesture {
    return self.splitRootViewController.beginGesture;
}
- (UIGestureRecognizer *)moveGesture {
    return self.splitRootViewController.moveGesture;
}
- (void)setIsSplitOpenning:(BOOL)aisSplitOpenning {
    self.splitRootViewController.isSplitOpenning = aisSplitOpenning;
}
- (BOOL)isSplitOpenning {
    return self.splitRootViewController.isSplitOpenning;
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

