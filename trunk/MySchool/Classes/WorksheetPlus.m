//
//  WorksheetPlus.m
//  MySchool
//
//  Created by Ashley Kayler on 3/4/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "WorksheetPlus.h"
#import "CompletedWorksheet.h"
#import "Worksheet.h"
#import "Student.h"
#import "WorksheetAnswer.h"
#import "WorksheetQuestion.h"
#import "User.h"
#import "Chapter.h"
#import "Lecture.h"

@implementation Worksheet (WorksheetPlus)

+(void)createCompletedWorksheetsForTeacher:(User*)teacher forChapter:(Chapter*)chapter{
	NSLog(@"Creating worksheet");
	Worksheet *worksheet = chapter.lecture.worksheet;
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	Student *student;
	for (student in teacher.students) {
		//for each create a completed worksheet and add it to the moc
		CompletedWorksheet *cWorksheetMO = (CompletedWorksheet *)[NSEntityDescription insertNewObjectForEntityForName:@"CompletedWorksheet" inManagedObjectContext:delegate.managedObjectContext];
		[cWorksheetMO setStudent:student];
		[cWorksheetMO setWorksheet:worksheet];
		[cWorksheetMO setDate:[NSDate date]];
		//create answers array
		WorksheetQuestion *wQuestion;
		for (wQuestion in worksheet.questions) {
			//int i = arc4random() % [wQuestion.answers count];
			//we add an answer at random. we can use the answer's question relationship to get the question back at a later time
			[cWorksheetMO addAnswersObject:[wQuestion.answers anyObject]];
		}
		NSLog(@"how many answers in completed worksheet:%d", [[cWorksheetMO answers] count]);
	}
	
	//save the managed object
	NSError *error;
	if (![delegate.managedObjectContext save:&error]) {
		NSLog(@"error saving managed object");
		// Handle the error.
	}
}

@end
