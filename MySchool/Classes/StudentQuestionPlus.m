//
//  StudentQuestionPlus.m
//  MySchool
//
//  Created by Ashley Kayler on 3/4/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "StudentQuestionPlus.h"


@implementation StudentQuestion (StudentQuestionPlus)

-(NSArray*)studentAnswersArray {
	
	NSArray *array = [[NSArray alloc] initWithArray:[self.answers allObjects]];
	NSSortDescriptor *descriptor =
    [[[NSSortDescriptor alloc] initWithKey:@"answer"
								 ascending:YES] autorelease];
	
	NSArray *descriptors = [NSArray arrayWithObjects:descriptor, nil];
	NSArray *sortedArray = [array sortedArrayUsingDescriptors:descriptors];
	
	//NSLog(@"%@", sortedArray);
	return sortedArray;
}

@end
