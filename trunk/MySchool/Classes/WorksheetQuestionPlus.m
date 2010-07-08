//
//  WorksheetQuestionPlus.m
//  MySchool
//
//  Created by ashleyk on 7/3/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "WorksheetQuestionPlus.h"


@implementation WorksheetQuestion (WorksheetQuestioPlus)

- (NSArray*) sortedAnswers {
	NSArray *array = [[NSArray alloc] initWithArray:[self.answers allObjects]];
	NSSortDescriptor *descriptor =
    [[[NSSortDescriptor alloc] initWithKey:@"correctness"
								 ascending:NO] autorelease];
	
	NSArray *descriptors = [NSArray arrayWithObjects:descriptor, nil];
	NSArray *sortedArray = [array sortedArrayUsingDescriptors:descriptors];
	
	return sortedArray;
	
}

@end
