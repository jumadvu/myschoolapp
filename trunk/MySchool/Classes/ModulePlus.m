//
//  ModulePlus.m
//  MySchool
//
//  Created by Ashley Kayler on 2/14/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "ModulePlus.h"


@implementation Module (ModulePlus)

-(NSArray*)chaptersArray {
	
	NSArray *array = [[NSArray alloc] initWithArray:[self.chapters allObjects]];
	NSSortDescriptor *descriptor =
    [[[NSSortDescriptor alloc] initWithKey:@"order"
								 ascending:YES] autorelease];
	
	NSArray *descriptors = [NSArray arrayWithObjects:descriptor, nil];
	NSArray *sortedArray = [array sortedArrayUsingDescriptors:descriptors];
	
	return sortedArray;
}

+(Module*) getModuleWithName:(NSString *)moduleName {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"title like '%@'", moduleName]];
	[request setPredicate:predicate];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Module" inManagedObjectContext:delegate.managedObjectContext];
	[request setEntity:entity];
		
	//fetch the data
	NSError *error;
	NSMutableArray *mutableFetchResults = [[delegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	
	NSLog(@"How many modules found: %d", [mutableFetchResults count]);
	return (Module*)[mutableFetchResults objectAtIndex:0];
}

@end
