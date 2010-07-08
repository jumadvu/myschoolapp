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
#import "WorksheetQuestionPlus.h"
#import "User.h"
#import "Chapter.h"
#import "Lecture.h"

@implementation Worksheet (WorksheetPlus)

+(void)createCompletedWorksheetsForTeacher:(User*)teacher forChapter:(Chapter*)chapter withPoints:(int)lectureScore{
	NSLog(@"Creating completed worksheets for each student");
	Worksheet *worksheet = chapter.lecture.worksheet;
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	Student *student;
	for (student in teacher.students) {
		NSLog(@"Creating completed worksheets for %@ with intelligence: %d", student.firstName, [student.intelligence intValue]);
		//for each student, create a completed worksheet and add it to the moc
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
			//returns a sorted array by correctness
			NSArray *allAnswers = [wQuestion sortedAnswers];
			WorksheetAnswer *wAnswer;
			//we add an answer based on the student's smarts and how well the teacher taught the lesson plus a random factor
			//we can use the answer's question relationship to get the question when presenting the homework for grading
			int randomFactor = arc4random() % 100;
			int successFactor = lectureScore + [student.intelligence intValue] + randomFactor;
			
			//if the successFactor is high enough, then we use the correct answer
			if (successFactor > 150) {
				//choose the correct answer
				NSLog(@"correct answer");
				 wAnswer = [allAnswers objectAtIndex:0];
				[cWorksheetMO addAnswersObject:wAnswer];
			} else {
				//choose an incorrect answer
				NSLog(@"wrong answer");
				int p = [wQuestion.answers count]-1;
				int q = arc4random() % p;
				q +=1;
				wAnswer = [allAnswers objectAtIndex:q];
				[cWorksheetMO addAnswersObject:wAnswer];
				
			}
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
