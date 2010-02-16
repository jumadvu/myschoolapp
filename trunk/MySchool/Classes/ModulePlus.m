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
    [[[NSSortDescriptor alloc] initWithKey:@"title"
								 ascending:YES
								  selector:@selector(localizedCaseInsensitiveCompare:)] autorelease];
	
	NSArray *descriptors = [NSArray arrayWithObjects:descriptor, nil];
	NSArray *sortedArray = [array sortedArrayUsingDescriptors:descriptors];
	
	return sortedArray;
}

@end
