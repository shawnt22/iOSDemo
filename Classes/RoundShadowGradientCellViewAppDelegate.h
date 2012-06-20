//
//  RoundShadowGradientCellViewAppDelegate.h
//  RoundShadowGradientCellView
//
//  Created by song teng on 10-7-9.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@class TSTableViewController;

@interface RoundShadowGradientCellViewAppDelegate : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
	TSTableViewController *theTableViewController;

    UIWindow *window;
}

- (IBAction)saveAction:sender;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, readonly) NSString *applicationDocumentsDirectory;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain)TSTableViewController *theTableViewController;

@end

