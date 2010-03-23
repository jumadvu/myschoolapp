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
	
	NSArray *storeItemNames = [NSArray arrayWithObjects:@"Alphabet Chart", @"Art Supplies", @"Globe", @"World Map",@"Cash Register", @"Baseball Bat & Ball", @"Fish Tank", @"Hamster", nil];
	NSArray *storeItemCosts = [NSArray arrayWithObjects:[NSNumber numberWithInt:25],[NSNumber numberWithInt:30],[NSNumber numberWithInt:40],[NSNumber numberWithInt:40],[NSNumber numberWithInt:80],[NSNumber numberWithInt:60],[NSNumber numberWithInt:100],[NSNumber numberWithInt:200],nil];
	NSArray *storeItemImages = [NSArray arrayWithObjects:@"alphabet.png",@"artsupplies.png",@"globe.png",@"worldmap.png",@"cashregister.png",@"baseballglove.png",@"fishtank.png",@"hamster.png", nil];
	
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
