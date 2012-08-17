//
//  SSplitContentViewController.m
//  SSplitControllerDemo
//
//  Created by 滕 松 on 12-8-17.
//  Copyright (c) 2012年 滕 松. All rights reserved.
//

#import "SSplitContentViewController.h"

@interface SSplitContentViewController()

@end
@implementation SSplitContentViewController

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

#pragma mark controller delegate
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    //  view
    TestView *_v = [[TestView alloc] initWithFrame:self.view.bounds];
    _v.backgroundColor = self.view.backgroundColor;
    _v.splitDelegate = self;
    [self.view addSubview:_v];
    [_v release];
    
//    //  table
//    TestTableView *_table = [[TestTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    _table.backgroundColor = self.view.backgroundColor;
//    _table.splitDelegate = self;
//    [self.view addSubview:_table];
//    [_table release];

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
- (void)splitContentView:(TestView *)splitContentView beginTouch:(UITouch *)touch {
    NSLog(@"begin touch : %@", touch);
}
- (void)splitContentView:(TestView *)splitContentView moveTouch:(UITouch *)touch {
    NSLog(@"move touch : %@", touch);
}
- (void)splitContentView:(TestView *)splitContentView endTouch:(UITouch *)touch {
    NSLog(@"end touch : %@", touch);
}
- (void)splitContentView:(TestView *)splitContentView receiveSwipeGesture:(UISwipeGestureRecognizer *)swipeGesture {
    NSLog(@"swip gesture : %@", swipeGesture.direction == UISwipeGestureRecognizerDirectionRight ? @"right" : @"left");
}

@end


#pragma mark - tset views

@implementation TestView
@synthesize splitDelegate, beginTouch, moveTouch;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.beginTouch = nil;
        self.moveTouch = nil;
        
        [self addSwipeGesture];
    }
    return self;
}
- (void)dealloc {
    self.beginTouch = nil;
    self.moveTouch = nil;
    [super dealloc];
}

- (void)addSwipeGesture {
    [SSplitContentUtil addSwipGestureWithContent:self];
}
- (void)responseSwipeGesture:(UISwipeGestureRecognizer *)gesture {
    [SSplitContentUtil responseSwipeGesture:gesture Content:self];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [SSplitContentUtil gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer Content:self];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [SSplitContentUtil touchesBegan:touches withEvent:event Content:self];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [SSplitContentUtil touchesEnded:touches withEvent:event Content:self];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [SSplitContentUtil touchesMoved:touches withEvent:event Content:self];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [SSplitContentUtil touchesCancelled:touches withEvent:event Content:self];
}

@end


@implementation TestTableView
@synthesize splitDelegate, beginTouch, moveTouch;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        self.beginTouch = nil;
        self.moveTouch = nil;
        
        //[self addSwipeGesture];
    }
    return self;
}
- (void)dealloc {
    self.beginTouch = nil;
    self.moveTouch = nil;
    [super dealloc];
}

- (void)addSwipeGesture {
    [SSplitContentUtil addSwipGestureWithContent:self];
}
- (void)responseSwipeGesture:(UISwipeGestureRecognizer *)gesture {
    [SSplitContentUtil responseSwipeGesture:gesture Content:self];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [SSplitContentUtil gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer Content:self];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [SSplitContentUtil touchesBegan:touches withEvent:event Content:self];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [SSplitContentUtil touchesEnded:touches withEvent:event Content:self];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [SSplitContentUtil touchesMoved:touches withEvent:event Content:self];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [SSplitContentUtil touchesCancelled:touches withEvent:event Content:self];
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
@synthesize splitDelegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSwipeGesture];
    }
    return self;
}
- (void)dealloc {
    [super dealloc];
}

- (void)addSwipeGesture {
    [SSplitContentUtil addSwipGestureWithContent:self];
}
- (void)responseSwipeGesture:(UISwipeGestureRecognizer *)gesture {
    [SSplitContentUtil responseSwipeGesture:gesture Content:self];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [SSplitContentUtil gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer Content:self];
}

@end

@implementation TestScrolView
@synthesize splitDelegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(self.bounds.size.width*2, self.bounds.size.height*2);
        
        [self addSwipeGesture];
    }
    return self;
}
- (void)dealloc {
    [super dealloc];
}

- (void)addSwipeGesture {
    [SSplitContentUtil addSwipGestureWithContent:self];
}
- (void)responseSwipeGesture:(UISwipeGestureRecognizer *)gesture {
    [SSplitContentUtil responseSwipeGesture:gesture Content:self];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [SSplitContentUtil gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer Content:self];
}

@end

