//
//  BehaviorReportPlus.m
//  MySchool
//
//  Created by Ashley Kayler on 4/19/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "BehaviorReportPlus.h"


@implementation BehaviorReport (BehaviorReportPlus)

+(NSString *)replaceName:(NSString*)name gender:(NSString*)gender inText:(NSString*)sometext {
	//NSString *finalString = [self.text stringByReplacingOccurrencesOfString:@"studentname" withString:name];
	
	NSMutableString *finalString = [[[NSMutableString alloc] initWithString:sometext] autorelease];
	
	[finalString replaceOccurrencesOfString:@"studentname" withString:name options:NSCaseInsensitiveSearch range:NSMakeRange (0, [finalString length])];
	if ([gender isEqualToString:@"Boy"]) {
		[finalString replaceOccurrencesOfString:@" she " withString:@" he " options:NSCaseInsensitiveSearch range:NSMakeRange (0, [finalString length])];
		[finalString replaceOccurrencesOfString:@" her " withString:@" his " options:NSCaseInsensitiveSearch range:NSMakeRange (0, [finalString length])];
	} else {
		[finalString replaceOccurrencesOfString:@" he " withString:@" she " options:NSCaseInsensitiveSearch range:NSMakeRange (0, [finalString length])];
		[finalString replaceOccurrencesOfString:@" his " withString:@" her " options:NSCaseInsensitiveSearch range:NSMakeRange (0, [finalString length])];
	}

	[finalString replaceOccurrencesOfString:@"studentname" withString:name options:NSCaseInsensitiveSearch range:NSMakeRange (0, [finalString length])];
	return finalString;
}

@end
