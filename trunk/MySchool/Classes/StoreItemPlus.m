//
//  StoreItemPlus.m
//  MySchool
//
//  Created by Ashley Kayler on 3/17/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "StoreItemPlus.h"
#import "StoreItem.h"
#import "MySchoolAppDelegate.h"
#import "Image.h"

@implementation StoreItem (StoreItemPlus)

+(void)createStoreItems {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	NSArray *storeItemNames = [NSArray arrayWithObjects:@"Alphabet Chart",@"12 Times Table Chart",@"Globe",@"Hamster" nil];
	NSArray *storeItemCosts = [NSArray arrayWithObjects:[NSNumber numberWithInt:25],[NSNumber numberWithInt:50],[NSNumber numberWithInt:100],[NSNumber numberWithInt:300] nil];
	NSArray *storeItemImages = [NSArray arrayWithObjects:@"AlphabetChart.png",@"TimesTables.png",@"Globe.png",@"Hamster.png" nil];
	
	for (int x=0; x<4; x++) {
		StoreItem *storeItemMO = (StoreItem *)[NSEntityDescription insertNewObjectForEntityForName:@"StoreItem" inManagedObjectContext:delegate.managedObjectContext];
		[storeItemMO setTitle:[storeItemNames objectAtIndex:x]];
		[storeItemMO setCost:[storeItemCosts objectAtIndex:x]];
		Image *imageMO = (StoreItem *)[NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:delegate.managedObjectContext];
		[imageMO setFileName:[storeItemImages objectAtIndex:x]];
		[storeItemMO setImage:imageMO];
	}
	
	//save the managed object context
	NSError *error;
	if (![delegate.managedObjectContext save:&error]) {
		NSLog(@"error saving managed object");
		// Handle the error.
	}
}

+(NSArray*)storeItemsArray {
	
	NSArray *array = [[NSArray alloc] initWithArray:[self fetchStoreItems]];
	if ([array count] == 0) {
		//if first time, add store items and fetch again
		[self createStoreItems];
		[array = fetchStoreItems];
	}
	//NSLog(@"%@", sortedArray);
	return array;
}

+(NSArray*)fetchStoreItems {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSLog(@"fetching store items data");
	//fetch data from the sql lite database
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	//finds all users who don't have parents (these are the parents)
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title != nil)"];
	[request setPredicate:predicate];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"StoreItem" inManagedObjectContext:delegate.managedObjectContext];
	[request setEntity:entity];

	//set up the sort orderings
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"cost" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];

	//fetch the data
	NSError *error;
	NSMutableArray *mutableFetchResults = [[delegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	return (NSArray*)mutableFetchResults;
}

@end
