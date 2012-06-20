//
//  TSTableViewController.m
//  RoundShadowGradientCellView
//
//  Created by song teng on 10-7-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

/*
 *	Any problem please email to shawnt22@gmail.com	=]
 */

#import "TSTableViewController.h"
#import "TSCellBackgroundView.h"

@interface TSTableViewController(Private)

- (CellStyle)checkCellStyleWith:(NSArray *)_datasource Index:(NSInteger)_index;

@end

@implementation TSTableViewController
@synthesize theDataSource;

#pragma mark -
#pragma mark init & dealloc
- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		
		// create datasource
		NSMutableArray *_datasource = [[NSMutableArray alloc] init];
		for (NSInteger loop = 0; loop < 1; loop++) {
			[_datasource addObject:[NSNumber numberWithInt:loop]];
		}
		self.theDataSource = _datasource;
		[_datasource release];
		
    }
    return self;
}
- (void)dealloc {
	[theDataSource release];
    [super dealloc];
}

#pragma mark -
#pragma mark ViewController Delegate Methods
- (void)loadView
{
	[super loadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.theDataSource count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TSCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	cell.textLabel.text = [NSString stringWithFormat:@"Row %d", [[self.theDataSource objectAtIndex:indexPath.row] intValue]];
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	TSCellBackgroundView *_backgroundview = [[TSCellBackgroundView alloc] init];
	_backgroundview.theCellStyle = [self checkCellStyleWith:self.theDataSource Index:indexPath.row];
	cell.backgroundView = _backgroundview;
	[_backgroundview release];
	
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return;
}

#pragma mark -
#pragma mark Check Cell Style
- (CellStyle)checkCellStyleWith:(NSArray *)_datasource Index:(NSInteger)_index
{
	NSInteger _count = [_datasource count];
	if (_count > 0) {
		if (_count > 1) {
			if (_index == 0) {
				return CellStyle_Top;
			}
			if (_index == _count - 1) {
				return CellStyle_Bottom;
			}
			return CellStyle_Middle;
		}
		return CellStyle_Single;
	}
	return CellStyle_None;
}

@end

