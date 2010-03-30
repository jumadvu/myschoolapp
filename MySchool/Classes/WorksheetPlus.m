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
		int y = [worksheet.questions count];
		int i = arc4random() % y;
		NSArray *allQuestionsArray = [NSArray arrayWithArray:[worksheet.questions allObjects]];
		WorksheetQuestion *wQuestion1 = [allQuestionsArray objectAtIndex:i];
		i++;
		if (i >= y-1) {
			i = 0;
		}
		WorksheetQuestion *wQuestion2 = [allQuestionsArray objectAtIndex:i];
		i++;
		if (i >= y-1) {
			i = 0;
		}
		WorksheetQuestion *wQuestion3 = [allQuestionsArray objectAtIndex:i];
		NSArray *selectedQuestions = [NSArray arrayWithObjects:wQuestion1, wQuestion2, wQuestion3, nil];
		WorksheetQuestion *wQuestion;
		for (wQuestion in selectedQuestions) {
			//we add an answer at random. we can use the answer's question relationship to get the question back at a later time
			//we should look at how well the user taught the lesson to determine the percentage of correct answers from the students
			int p = [wQuestion.answers count];
			int q = arc4random() % p;
			NSArray *allAnswers = [NSArray arrayWithArray:[wQuestion.answers allObjects]];
			WorksheetAnswer *wAnswer = [allAnswers objectAtIndex:q];
			[cWorksheetMO addAnswersObject:wAnswer];
			NSLog(@"%@",wQuestion.text);
			NSLog(@"%@", wAnswer.answer);
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
