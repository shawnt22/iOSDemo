//
//  AppDelegate.m
//  SCategoryControlDemo
//
//  Created by 滕 松 on 12-10-25.
//  Copyright (c) 2012年 shawnt22@gmail.com. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate()
@property (nonatomic, retain) NSMutableArray *categories;
@end
@implementation AppDelegate
@synthesize categories;

- (void)dealloc
{
    self.categories = nil;
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.categories = [Category testCategories];
    
    SCategoryControl *_control = [[SCategoryControl alloc] initWithFrame:CGRectMake(10, 100, self.window.bounds.size.width-20, k_categorycontrol_height)];
    _control.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    _control.controlDataSource = self;
    [self.window addSubview:_control];
    [_control release];
    
    [_control reloadControl];
    
    return YES;
}

#pragma mark category control datasource
- (NSInteger)itemNumberOfCategoryControl:(SCategoryControl *)categoryControl {
    return [self.categories count];
}
- (CGFloat)categoryControl:(SCategoryControl *)categoryControl widthAtIndexPath:(SCategoryIndexPath)indexPath {
    Category *_category = [self.categories objectAtIndex:indexPath.column];
    return _category.itemSize.width;
}
- (CGFloat)categoryControl:(SCategoryControl *)categoryControl heightAtIndexPath:(SCategoryIndexPath)indexPath {
    Category *_category = [self.categories objectAtIndex:indexPath.column];
    return _category.itemSize.height;
}
- (CGFloat)categoryControl:(SCategoryControl *)categoryControl marginLeftAtIndexPath:(SCategoryIndexPath)indexPath {
    return k_categorycontrol_item_margin_left;
}
- (UIView<SCategoryItemProtocol> *)categoryControl:(SCategoryControl *)categoryControl itemAtIndexPath:(SCategoryIndexPath)indexPath {
    NSString *_identifier = @"item";
    
    SCategoryItem *_item = (SCategoryItem *)[categoryControl dequeueReusableItemWithIdentifier:_identifier];
    if (!_item) {
        _item = [[[SCategoryItem alloc] defaultItemWithReusableIdentifier:_identifier] autorelease];
    }
    Category *_category = [self.categories objectAtIndex:indexPath.column];
    [_item refreshItemWithContent:_category.content Frame:_category.itemFrame];
    
    return _item;
}

#pragma mark app delegate
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end


@implementation Category
@synthesize content, itemSize, itemFrame;

- (void)dealloc {
    self.content = nil;
    [super dealloc];
}

@end

@implementation Category(Test)

+ (NSMutableArray *)testCategories {
    NSMutableArray *_categories = [NSMutableArray array];
    for (NSInteger index = 0; index < 20; index++) {
        Category *_category = [Category randomContentCategory];
        CGSize _itemSize = [SCategoryItem itemSizeWithContent:_category.content Font:k_category_item_content_font ConstrainedToSize:k_category_item_content_constrained_size];
        _category.itemSize = _itemSize;
        [_categories addObject:_category];
    }
    return _categories;
}
+ (Category *)randomContentCategory {
    Category *_category = [[[Category alloc] init] autorelease];
    
    NSArray *_contents = [NSMutableArray arrayWithObjects:@"long category", @"category", @"cgy", @"very loooooooooooooong category", nil];
    NSInteger _index = arc4random() % [_contents count];
    _category.content = [_contents objectAtIndex:_index];
    
    return _category;
}

@end