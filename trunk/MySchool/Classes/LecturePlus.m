//
//  LecturePlus.m
//  MySchool
//
//  Created by Ashley Kayler on 2/18/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "LecturePlus.h"


@implementation Lecture (LecturePlus)

-(NSArray*)keywordSetArray {
	
	NSArray *array = [[NSArray alloc] initWithArray:[self.keywordSets allObjects]];
	NSSortDescriptor *descriptor =
    [[[NSSortDescriptor alloc] initWithKey:@"order"
								 ascending:YES] autorelease];
	
	NSArray *descriptors = [NSArray arrayWithObjects:descriptor, nil];
	NSArray *sortedArray = [array sortedArrayUsingDescriptors:descriptors];
	NSLog(@"how many keywords in set %d", [array count]);
	return sortedArray;
}

@end
