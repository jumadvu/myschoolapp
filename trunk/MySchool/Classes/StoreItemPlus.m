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
	
	NSArray *storeItemNames = [NSArray arrayWithObjects:@"Piano", @"Alphabet Chart", @"Art Supplies", @"Globe", @"Cash Register", @"Baseball Bat & Ball", @"Fish Tank", @"Hamster", nil];
	NSArray *storeItemCosts = [NSArray arrayWithObjects:[NSNumber numberWithInt:225],[NSNumber numberWithInt:330],[NSNumber numberWithInt:340],[NSNumber numberWithInt:440],[NSNumber numberWithInt:580],[NSNumber numberWithInt:660],[NSNumber numberWithInt:700],[NSNumber numberWithInt:900],nil];
	NSArray *storeItemImages = [NSArray arrayWithObjects:@"musiclesson.png",@"alphabet.png",@"artsupplies.png",@"globe.png",@"cashregister.png",@"baseballglove.png",@"fishtank.png",@"hamster.png", nil];
	
	for (int x=0; x<[storeItemNames count]; x++) {
		StoreItem *storeItemMO = (StoreItem *)[NSEntityDescription insertNewObjectForEntityForName:@"StoreItem" inManagedObjectContext:delegate.managedObjectContext];
		[storeItemMO setTitle:[storeItemNames objectAtIndex:x]];
		[storeItemMO setCost:[storeItemCosts objectAtIndex:x]];
		Image *imageMO = (Image *)[NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:delegate.managedObjectContext];
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
	
	NSArray *array = [[NSArray alloc] initWithArray:[StoreItem fetchStoreItems]];
	if ([array count] == 0) {
		//if first time, add store items and fetch again
		[StoreItem createStoreItems];
		array = [StoreItem fetchStoreItems];
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
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"cost" ascending:YES];
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