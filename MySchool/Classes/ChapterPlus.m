//
//  ChapterPlus.m
//  MySchool
//
//  Created by Ashley Kayler on 2/22/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "ChapterPlus.h"
#import "User.h"
#import "CompletedLesson.h"

@implementation Chapter (ChapterPlus)

- (NSNumber*)maxPointsForUsersCompletedLessons:(NSArray*)completedLessons {
	
	CompletedLesson *completedLesson;
	int points = -1;
							
	for (completedLesson in completedLessons) {
		NSLog(@"completed lesson");
		if (completedLesson.chapter == self) {
			if ([completedLesson.points intValue] > points) {
				points = [completedLesson.points intValue];
			}
		}
	}
	
	if (points == -1) {
		return nil;
	} else {
		NSNumber *points = [NSNumber numberWithInt:(int)points];
		return (NSNumber*)points;
	}
}

- (NSString*)maxPointsForUsersCompletedLessonsAsString:(NSArray*)completedLessons {
	
	CompletedLesson *completedLesson;
	int points = -1;
	
	for (completedLesson in completedLessons) {
		NSLog(@"completed lesson");
		if (completedLesson.chapter == self) {
			if ([completedLesson.points intValue] > points) {
				points = [completedLesson.points intValue];
			}
		}
	}
	
	if (points == -1) {
		return nil;
	} else {
		return [NSString stringWithFormat:@"%d", points];
	}
}

@end
