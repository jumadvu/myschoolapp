//
//  CompletedWorksheetPlus.m
//  MySchool
//
//  Created by Ashley Kayler on 3/15/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "CompletedWorksheetPlus.h"

@implementation CompletedWorksheet (CompletedWorksheetPlus)

-(NSString*)letterGrade {
	NSString *myGrade;
	switch ([[self grade] intValue]) {
		case 0:
			myGrade = [NSString stringWithFormat:@"D"];
			break;
		case 1:
			myGrade = [NSString stringWithFormat:@"B-"];
			break;
		case 2:
			myGrade = [NSString stringWithFormat:@"A-"];
			break;
		case 3:
			myGrade = [NSString stringWithFormat:@"A+"];
			break;
		default:
			break;
	}
	return myGrade;
}

@end
