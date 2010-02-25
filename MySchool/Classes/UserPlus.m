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

@implementation User (UserPlus)

-(NSString *)fullName {
	return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

-(UIImage *)avatarImage {
	//translates the numeric value for the avatarImage into a string value and creates the image
	//NSArray imageNames = [NSArray initWithObjects:@"woman.png",@"man.png",nil];
	UIImage *image = [UIImage imageNamed:[self.avatar avatarImage]];
	//UIImageView *imageView = [UIImageView initWithImage:image];
	return image;
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
@end
