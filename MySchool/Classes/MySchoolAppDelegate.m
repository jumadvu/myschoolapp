//
//  MySchoolAppDelegate.m
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright DataJedi 2010. All rights reserved.
//

#import "MySchoolAppDelegate.h"
#import "Welcome.h"
#import "UserMO.h"
#import "MainMenu.h"
#import "AccountSelection.h"

@implementation MySchoolAppDelegate

@synthesize window;
@synthesize navCon;
@synthesize users;
@synthesize managedObjectModel;
@synthesize managedObjectContext;
@synthesize persistentStoreCoordinator;
@synthesize teacher;

- (void)dealloc {
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
	[teacher release];
	[navCon release];
    [window release];
	[users release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    // Override point for customization after app launch 
	
	// this helps debugging by handling references to over released objects with more info to console
	 if(getenv("NSZombieEnabled") || getenv("NSAutoreleaseFreedObjectCheckEnabled")) {
		 NSLog(@"NSZombieEnabled/NSAutoreleaseFreedObjectCheckEnabled enabled!");
	 }
	//hide nav bar
	[navCon setNavigationBarHidden:YES];

	//add navigation controller view  (root view is set to main menu in nib)
    [window addSubview:navCon.view];
	
    [window makeKeyAndVisible];
	
	//fetch stored data from the sqlite database and send user to appropriate page
	[self fetchData];
}

- (void)fetchData {
	
	NSLog(@"fetching data from sql lite store");
	//fetch data from the sql lite database
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	//finds all users who don't have parents (these are the parents)
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(avatarImage != nil)"];
	[request setPredicate:predicate];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
	[request setEntity:entity];
	
	//set up the sort orderings
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];
	
	//fetch the data
	NSError *error;
	NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		// Handle the error.
		NSLog(@"error fetching results");
	} else {
		if ([mutableFetchResults count] == 1) {
			NSLog(@"Found one teacher");
			//UserMO *aTeacher = [[UserMO alloc] init];
			//aTeacher = [mutableFetchResults objectAtIndex:0];
			// set the current teacher account and go to main menu
			[self setTeacher:[mutableFetchResults objectAtIndex:0]];
			//[aTeacher release];
			MainMenu *vc = [[[MainMenu alloc] initWithNibName:nil bundle:nil] autorelease];
			[navCon pushViewController:vc animated:YES];					 
		} else {
			if ([mutableFetchResults count] > 1) {
				//more than one teacher account. Go to account selection page
				NSLog(@"Found this many teachers: %d", [mutableFetchResults count]);
				[self setUsers:mutableFetchResults];
				AccountSelection *vc = [[[AccountSelection alloc] initWithStyle:UITableViewStylePlain] autorelease];
				[vc setAccounts:users];
				[navCon pushViewController:vc animated:YES];					 			
			} else {
				//no teacher accounts. Must be first time login. Go to welcome page
				NSLog(@"No results found. Present Welcome Page");
				Welcome *vc = [[[Welcome alloc] initWithNibName:nil bundle:nil] autorelease];
				[navCon pushViewController:vc animated:YES];
			}
		}
		
	}
	NSLog(@"finished fetching data from sql lite store");
	//set the parent account info
	[mutableFetchResults release];
	[request release];
	
	
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
	NSLog(@"getting managed object context");
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	NSLog(@"creating a managed object context");
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [NSManagedObjectContext new];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
	NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"MySchool.sqlite"];
	//NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"Paykids.xml"];
	/*
	 Set up the store.
	 For the sake of illustration, provide a pre-populated default store.
	 */
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// If the expected store doesn't exist, copy the default store.
	if (![fileManager fileExistsAtPath:storePath]) {
		NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"MySchool" ofType:@"sqlite"];
		//NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"Paykids" ofType:@"xml"];
		if (defaultStorePath) {
			[fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
		}
	}
	
	NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
	
	NSError *error;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		//if (![persistentStoreCoordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}

#pragma mark -
#pragma mark Application's documents directory

/**
 Returns the path to the application's documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
