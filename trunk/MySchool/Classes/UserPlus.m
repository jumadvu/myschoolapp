//
//  UserPlus.m
//  MySchool
//
//  Created by Ashley Kayler on 2/1/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "UserPlus.h"
#import "Avatar.h"
#import "Student.h"
#import "CompletedWorksheet.h"

@implementation User (UserPlus)

-(NSString *)fullName {
	return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

-(UIImage *)avatarImage {
	//translates the numeric value for the avatarImage into a string value and creates the image
	UIImage *image = [UIImage imageNamed:[self.avatar avatarImage]];
	//UIImageView *imageView = [UIImageView initWithImage:image];
	return image;
}

-(UIImage *)avatarImageWaistUp {
	//translates the numeric value for the avatarImage into a string value and creates the image
	//NSArray imageNames = [NSArray initWithObjects:@"woman.png",@"man.png",nil];
	UIImage *image = [UIImage imageNamed:[self.avatar avatarImageWaistUp]];
	//UIImageView *imageView = [UIImageView initWithImage:image];
	return image;
}

-(NSString*)title {
	if ([self.gender isEqualToString:@"male"]) {
		return [NSString stringWithFormat:@"Mister %@", self.lastName];
	} else {
		return [NSString stringWithFormat:@"Ms %@", self.lastName];
	}
}

-(NSArray*)studentsArray {
	
	NSArray *array = [[NSArray alloc] initWithArray:[self.students allObjects]];
	NSSortDescriptor *descriptor =
    [[[NSSortDescriptor alloc] initWithKey:@"order"
								 ascending:YES] autorelease];
	
	NSArray *descriptors = [NSArray arrayWithObjects:descriptor, nil];
	NSArray *sortedArray = [array sortedArrayUsingDescriptors:descriptors];
	
	return sortedArray;
}

-(NSArray*)ungradedPapers {
	
	NSArray *array = [[[NSArray alloc] initWithArray:[self.students allObjects]] autorelease];
	NSMutableArray *completedWorksheets = [[NSMutableArray alloc] init];
	Student *student;
	for (student in array) {
		CompletedWorksheet *cWorksheet;
		for (cWorksheet in [student.worksheets allObjects]) {
			//add worksheet if not yet graded
			if ([cWorksheet.grade intValue] == -1) {
				[completedWorksheets addObject:cWorksheet];
			}
		}
	}
	NSSortDescriptor *descriptor =
    [[[NSSortDescriptor alloc] initWithKey:@"date"
								 ascending:YES] autorelease];
	
	NSArray *descriptors = [NSArray arrayWithObjects:descriptor, nil];
	NSArray *sortedArray = [completedWorksheets sortedArrayUsingDescriptors:descriptors];
	
	return sortedArray;
}

-(NSNumber*)pointsAvailable {
	
	return [NSNumber numberWithInt:[self.totalPoints intValue] - [self.pointsSpent intValue]];
}

-(void) adjustApprovalRating:(NSNumber*)value {
	if ([value intValue] > 0) {
		if ([self.rating intValue] < 100) {
			int newRating = [self.rating intValue]+1;
			[self setRating:[NSNumber numberWithInt:newRating]];
		}
	} else {
		if ([self.rating intValue] > 3) {
			int newRating = [self.rating intValue]-3;
			[self setRating:[NSNumber numberWithInt:newRating]];
		}
	}

}

@end
