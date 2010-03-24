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
#import "Lecture.h"
#import "StudentQuestion.h"

@implementation Chapter (ChapterPlus)

-(NSArray*)studentQuestionsArray {
	
	NSArray *array = [[NSArray alloc] initWithArray:[self.lecture.studentQuestions allObjects]];
	NSSortDescriptor *descriptor =
    [[[NSSortDescriptor alloc] initWithKey:@"text"
								 ascending:YES] autorelease];
	
	NSArray *descriptors = [NSArray arrayWithObjects:descriptor, nil];
	NSArray *sortedArray = [array sortedArrayUsingDescriptors:descriptors];
	
	return sortedArray;
}

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

- (NSData*)createFormData:(NSDictionary*)myDictionary withBoundary:(NSString*)myBounds {
	
	NSMutableData *myReturn = [[NSMutableData alloc] initWithCapacity:10];
	
	NSArray *formKeys = [myDictionary allKeys];
	for (int i = 0; i < [formKeys count]; i++) {
		[myReturn appendData:[[NSString stringWithFormat:@"--%@\n",myBounds] dataUsingEncoding:NSASCIIStringEncoding]]; 
		[myReturn appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\n\n%@\n",[formKeys objectAtIndex:i],[myDictionary valueForKey:[formKeys objectAtIndex:i]]] dataUsingEncoding:NSASCIIStringEncoding]];
	}
	[myReturn appendData:[[NSString stringWithFormat:@"--%@--\n",myBounds] dataUsingEncoding:NSASCIIStringEncoding]];
	
	return (NSData*)myReturn;
}					


- (void)sendEmail {    
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	NSString *myBounds = @"1234";
	
	NSArray *keys = [NSArray arrayWithObjects:@"email", @"message", @"subject", nil];
	NSArray *objects = [NSArray arrayWithObjects:delegate.parentEmail1, [self emailMessage], @"MySchool Update - Ask your child about...", nil];
	NSDictionary *myPostDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
	
	NSData *myPostData = [self createFormData:myPostDictionary withBoundary:myBounds];
	
	NSURL *myURL = [NSURL URLWithString:@"http://www.calsquash.com/myschoolMail.php"];
	
	NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:myURL];
	NSString *myContent = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",myBounds];
	[myRequest setValue:myContent forHTTPHeaderField:@"Content-type"];
	[myRequest setHTTPMethod:@"POST"];
	[myRequest setHTTPBody:myPostData];
	
	NSURLResponse *response;
    NSError *error;
	// We should probably be parsing the data returned by this call, for now just check the error.
    [NSURLConnection sendSynchronousRequest:myRequest returningResponse:&response error:&error];
	
}

-(NSString*)emailMessage {
	NSMutableString *message = [NSMutableString stringWithFormat:@"Your child has just completed a MySchool Unit: %@", [self title]];
	[message appendString:@"\n\nWe urget you to ask him/her some questions about it, like these:"];
	StudentQuestion *question;
	for (question in self.lecture.studentQuestions) {
		[message appendString:@"\n\n"];
		[message appendString:question.text];
	}
	
	return (NSString*)message;
}

@end
