//
//  MySchoolAppDelegate.m
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright DataJedi 2010. All rights reserved.
//

#import "MySchoolAppDelegate.h"
#import "Welcome.h"
#import "UserPlus.h"
#import "MainMenu.h"
#import "AccountSelection.h"
#import "Library.h"
#import "testing123.h"

@implementation MySchoolAppDelegate

@synthesize window;
@synthesize navCon;
@synthesize users;
@synthesize managedObjectModel;
@synthesize managedObjectContext;
@synthesize persistentStoreCoordinator;
@synthesize teacher;
@synthesize currentChapter;
@synthesize pListContents;
@synthesize parentEmail1;
@synthesize parentEmail2;

- (void)dealloc {
	[pListContents release];
	[parentEmail1 release];
	[parentEmail2 release];
	[currentChapter release];
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
	
	//use this boolean to go directly to the testing page: testing123
	BOOL testing = NO;
	if (testing) {
		testing123 *vc = [[[testing123 alloc] initWithNibName:nil bundle:nil] autorelease];
		[navCon pushViewController:vc animated:YES];
	} else {
		[self fetchModuleData];
		[self fetchUserData];
	}

	[self fetchPListData];
}

- (void)fetchModuleData {
	NSArray *modules = [[NSArray alloc] init];
	modules = [Library fetchModulesFromDBforGrade:[NSNumber numberWithInt:2]];
	if ([modules count] == 0) {
		//if there are no modules in the library, its the first time through
		//add the xml modules
		//add library modules
		[Library addXMLModule:@"dinosaurs" toDatabaseContext:managedObjectContext];
		[Library addXMLModule:@"sustain" toDatabaseContext:managedObjectContext];
		[Library addXMLModule:@"insects" toDatabaseContext:managedObjectContext];
		[Library addXMLModule:@"planets" toDatabaseContext:managedObjectContext];
		[Library addXMLModule:@"historicalFigures" toDatabaseContext:managedObjectContext];

		//add behavior reports
		[Library addBehaviorReports:@"behaviorReports" toDatabaseContext:managedObjectContext];

		//add personal questions
		[Library addPersonalQuestionsToDatabaseContext:managedObjectContext];
		
	}
	[modules release];
}

- (void)fetchUserData {
	
	NSLog(@"fetching data from sql lite store");
	//fetch data from the sql lite database
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	//finds all users who don't have parents (these are the parents)
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(firstName != nil)"];
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
				AccountSelection *vc = [[[AccountSelection alloc] initWithNibName:nil bundle:nil] autorelease];
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

-(void)fetchPListData {
	// Check for data in Documents directory. Copy default data.plist to Documents if not found.
	NSString *pathToFile = [self pathToPList];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	if ([fileManager fileExistsAtPath:pathToFile] == NO) {
		NSString *pathToDefaultPlist = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
		if ([fileManager copyItemAtPath:pathToDefaultPlist toPath:pathToFile error:&error] == NO) {
			NSAssert1(0, @"Failed to copy data with error message '%@'.", [error localizedDescription]);
		}
	}
	// grab the parent email data
	self.pListContents = [[[NSMutableDictionary alloc] initWithContentsOfFile:pathToFile] autorelease];
	self.parentEmail1 = [pListContents valueForKey:@"ParentEmail1"];
	self.parentEmail2 = [pListContents valueForKey:@"ParentEmail2"];
	NSLog(@"%@", self.parentEmail1);
	
}

-(void)savingDataToPlist {
	
	[self.pListContents setObject:self.parentEmail1 forKey:@"ParentEmail1"];
	[self.pListContents setObject:self.parentEmail2 forKey:@"ParentEmail2"];
	[self.pListContents writeToFile:[self pathToPList] atomically:YES];		
	
}

-(NSString*)pathToPList {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *pathToFile = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
	return pathToFile;
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
	//NSLog(@"getting managed object context");
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	//NSLog(@"creating a managed object context");
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
