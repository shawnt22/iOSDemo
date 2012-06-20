//
//  TSTableViewController.h
//  RoundShadowGradientCellView
//
//  Created by song teng on 10-7-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TSTableViewController : UITableViewController {
	NSArray *theDataSource;

}
@property (nonatomic, retain)NSArray *theDataSource;

@end
