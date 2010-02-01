//
//  UserMO.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "UserMO.h"


@implementation UserMO

-(NSString *)fullName {
	return [NSString stringWithFormat:@"%@ Smith", self.firstName];
}

-(UIImage *)avatar {
	//translates the numeric value for the avatarImage into a string value and creates the image
	//NSArray imageNames = [NSArray initWithObjects:@"woman.png",@"man.png",nil];
	UIImage *image = [UIImage imageNamed:[self avatarImage]];
	//UIImageView *imageView = [UIImageView initWithImage:image];
	return image;
}


@end
