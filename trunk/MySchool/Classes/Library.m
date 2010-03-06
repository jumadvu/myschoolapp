//
//  Library.m
//  MySchool
//
//  Created by Ashley Kayler on 2/9/10.
//  Copyright 2010 DataJedi. All rights reserved.
//
#import "MySchoolAppDelegate.h"
#import "Library.h"
#import "TBXML.h"
#import "Module.h"
#import "Chapter.h"
#import "Lecture.h"
#import "StudentQuestion.h"
#import "Keyword.h"
#import "KeywordSet.h"
#import "StudentAnswer.h"
#import "Article.h"
#import "Image.h"
#import "Worksheet.h"
#import "WorksheetQuestion.h"
#import "WorksheetAnswer.h"

@implementation Library

+(NSArray*)subjectsForGrade:(NSNumber*)gradeLevel {
	
	NSString *xmlFile = [self whichXMLFile:gradeLevel];

	NSMutableArray *subjects = [[[NSMutableArray alloc] init] autorelease];
	//subjects is an array of all subjects in this grade level (eg 'History', 'Science', 'Math')
	//each subject is an array which has two objects: object at index 0 : a string containing the subject name
	//subject : object at index 1 is an array (modules) 
	//each module contains the title of the module and the filename of the xml file associated with that module;

	TBXML * tbxml = [[TBXML alloc] initWithXMLFile:xmlFile fileExtension:@"xml"];
	TBXMLElement * root = tbxml.rootXMLElement;

	//get the first subject from the xml file
	TBXMLElement * subject = [tbxml childElementNamed:@"subject" parentElement:root];
	while (subject!=nil) {
		NSString * subjectName = [tbxml valueOfAttributeNamed:@"name" forElement:subject];
		NSMutableArray *modules = [[NSMutableArray alloc] init];
		
		TBXMLElement * module = [tbxml childElementNamed:@"module" parentElement:subject];		
		while (module!=nil) {
			NSString * mTitle = [tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:module]];
			NSString * mFileName = [tbxml textForElement:[tbxml childElementNamed:@"fileName" parentElement:module]];
			NSArray *aModule = [[NSArray alloc] initWithObjects:mTitle, mFileName, nil];
			[modules addObject:aModule];
			[aModule release];
			module = [tbxml nextSiblingNamed:@"module" searchFromElement:module];
		}

		NSArray *aSubject = [[NSArray alloc] initWithObjects:subjectName, modules, nil];
		[subjects addObject:aSubject];
		[aSubject release];
		[modules release];
		subject = [tbxml nextSiblingNamed:@"subject" searchFromElement:subject];

	}
	[tbxml release];
	
	return subjects;
}

+ (NSString *) whichXMLFile:(NSNumber*)gradeLevel {
	int myGradeLevel = [gradeLevel intValue];
	//select xml module to peruse
	NSString *xmlFileName;
	switch (myGradeLevel) {
		case 2:
			xmlFileName = [NSString stringWithFormat:@"modules"];
			break;
		case 3:
			xmlFileName = [NSString stringWithFormat:@"modules"];
			break;
		default:
			break;
	}
	return xmlFileName;
	
}

+(NSArray*)fetchModulesFromDBforGrade:(NSNumber*)gradeLevel {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSLog(@"fetching data from sql lite store");
	//fetch data from the sql lite database
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	//finds all users who don't have parents (these are the parents)
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(title != nil)"];
	[request setPredicate:predicate];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Module" inManagedObjectContext:delegate.managedObjectContext];
	[request setEntity:entity];
	
	//set up the sort orderings
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];
	
	//fetch the data
	NSError *error;
	NSMutableArray *mutableFetchResults = [[delegate.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	return (NSArray*)mutableFetchResults;
	
}

+(void)addXMLModule:(NSString*)xmlFile toDatabaseContext:(NSManagedObjectContext*)moc {
	NSLog(@"Adding xml module %@", xmlFile);
	Module *moduleMO = (Module *)[NSEntityDescription insertNewObjectForEntityForName:@"Module" inManagedObjectContext:moc];
	TBXML * tbxml = [[TBXML alloc] initWithXMLFile:xmlFile fileExtension:@"xml"];
	TBXMLElement * root = tbxml.rootXMLElement;
	TBXMLElement * module = [tbxml childElementNamed:@"module" parentElement:root];
	[moduleMO setTitle:[tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:module]]];
	[moduleMO setGradeLevel:[NSNumber numberWithInt:[[tbxml textForElement:[tbxml childElementNamed:@"gradeLevel" parentElement:module]] intValue]]];
	[moduleMO setSubject:[tbxml textForElement:[tbxml childElementNamed:@"superSubject" parentElement:module]]];
	
	
	//grab each chapter
	TBXMLElement * chapter=[tbxml childElementNamed:@"chapter" parentElement:module];
	int chapterCount = 0;
	while (chapter!=nil){
		Chapter *chapterMO = (Chapter *)[NSEntityDescription insertNewObjectForEntityForName:@"Chapter" inManagedObjectContext:moc];
		Lecture *lectureMO = (Lecture *)[NSEntityDescription insertNewObjectForEntityForName:@"Lecture" inManagedObjectContext:moc];
		TBXMLElement * lecture=[tbxml childElementNamed:@"lecture" parentElement:chapter];
		[lectureMO setChapter:chapterMO];
		[lectureMO setTitle:[tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:lecture]]];
		[lectureMO setText:[tbxml textForElement:[tbxml childElementNamed:@"text" parentElement:lecture]]];
		
		//get the keyword sets
		TBXMLElement * keywordSet=[tbxml childElementNamed:@"keywordSet" parentElement:lecture];
		int keywordSetCount = 0;
		while (keywordSet!=nil) {
			KeywordSet *keySetMO = (KeywordSet *)[NSEntityDescription insertNewObjectForEntityForName:@"KeywordSet" inManagedObjectContext:moc];
			Keyword *awordMO = (Keyword *)[NSEntityDescription insertNewObjectForEntityForName:@"Keyword" inManagedObjectContext:moc];
			[awordMO setWord:[tbxml valueOfAttributeNamed:@"word" forElement:keywordSet]];
			[awordMO setCorrect:[NSNumber numberWithInt:1]];
			[keySetMO addWordsObject:awordMO];
			[keySetMO setLecture:lectureMO];
			[keySetMO setOrder:[NSNumber numberWithInt:keywordSetCount]];
			TBXMLElement * word=[tbxml childElementNamed:@"word" parentElement:keywordSet];		
			while (word!=nil) {
				Keyword *wordMO = (Keyword *)[NSEntityDescription insertNewObjectForEntityForName:@"Keyword" inManagedObjectContext:moc];
				[wordMO setCorrect:[NSNumber numberWithInt:0]];
				[wordMO setWord:[tbxml textForElement:word]];
				[keySetMO addWordsObject:wordMO];
				word = [tbxml nextSiblingNamed:@"word" searchFromElement:word];
			}
			keywordSet = [tbxml nextSiblingNamed:@"keywordSet" searchFromElement:keywordSet];
			keywordSetCount++;
		}
		
		//grab the student questions
		TBXMLElement * studentQ=[tbxml childElementNamed:@"studentQuestion" parentElement:lecture];		
		while (studentQ!=nil) {
			StudentQuestion *studentQMO = (StudentQuestion *)[NSEntityDescription insertNewObjectForEntityForName:@"StudentQuestion" inManagedObjectContext:moc];
			[studentQMO setText:[tbxml textForElement:[tbxml childElementNamed:@"text" parentElement:studentQ]]];
			[studentQMO setStudentType:[NSNumber numberWithInt:[[tbxml textForElement:[tbxml childElementNamed:@"studentType" parentElement:studentQ]] intValue]]];
			[studentQMO setLecture:lectureMO];
			TBXMLElement * answer=[tbxml childElementNamed:@"answer" parentElement:studentQ];		
			while (answer!=nil) {
				StudentAnswer *answerMO = (StudentAnswer *)[NSEntityDescription insertNewObjectForEntityForName:@"StudentAnswer" inManagedObjectContext:moc];
				[answerMO setAnswer:[tbxml textForElement:answer]];
				[answerMO setCorrectness:[NSNumber numberWithInt:[[tbxml valueOfAttributeNamed:@"correctness" forElement:answer] intValue]]];
				[studentQMO addAnswersObject:answerMO];
				answer = [tbxml nextSiblingNamed:@"answer" searchFromElement:answer];
			}
			studentQ = [tbxml nextSiblingNamed:@"studentQuestion" searchFromElement:studentQ];
		}
		
		[chapterMO setOrder:[NSNumber numberWithInt:chapterCount]];
		
		[chapterMO setTitle:[tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:chapter]]];
		Article *article = (Article *)[NSEntityDescription insertNewObjectForEntityForName:@"Article" inManagedObjectContext:moc];
		TBXMLElement * art =[tbxml childElementNamed:@"article" parentElement:chapter];
		[article setText:[tbxml textForElement:[tbxml childElementNamed:@"text" parentElement:art]]];
		
		//get the article images
		TBXMLElement * image=[tbxml childElementNamed:@"image" parentElement:art];
		int imageCount = 0;
		while (image!=nil) {
			Image *imageMO = (Image *)[NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:moc];
			[imageMO setFileName:[tbxml textForElement:[tbxml childElementNamed:@"file" parentElement:image]]];
			[imageMO setDesc:[tbxml textForElement:[tbxml childElementNamed:@"desc" parentElement:image]]];
			[imageMO setArticle:article];
			[imageMO setOrder:[NSNumber numberWithInt:imageCount]];
			[article addImagesObject:imageMO];
			
			image = [tbxml nextSiblingNamed:@"image" searchFromElement:image];
			imageCount++;
		}

		//get the worksheet questions images
		Worksheet *worksheetMO = (Worksheet *)[NSEntityDescription insertNewObjectForEntityForName:@"Worksheet" inManagedObjectContext:moc];
		[worksheetMO setLecture:lectureMO];
		TBXMLElement * wQuestion=[tbxml childElementNamed:@"worksheetQuestion" parentElement:chapter];
		while (wQuestion!=nil) {
			NSLog(@"adding worksheet question");
			WorksheetQuestion *worksheetQuestionMO = (WorksheetQuestion *)[NSEntityDescription insertNewObjectForEntityForName:@"WorksheetQuestion" inManagedObjectContext:moc];
			NSLog(@"1");
			[worksheetQuestionMO setText:[tbxml textForElement:[tbxml childElementNamed:@"text" parentElement:wQuestion]]];
			NSLog(@"2");
			[worksheetQuestionMO setWorksheet:worksheetMO];
			NSLog(@"3");
			TBXMLElement * answer=[tbxml childElementNamed:@"answer" parentElement:wQuestion];		
			NSLog(@"4");
			while (answer!=nil) {
				NSLog(@"adding answer");
				WorksheetAnswer *answerMO = (WorksheetAnswer *)[NSEntityDescription insertNewObjectForEntityForName:@"WorksheetAnswer" inManagedObjectContext:moc];
				[answerMO setAnswer:[tbxml textForElement:answer]];
				[answerMO setCorrectness:[NSNumber numberWithInt:[[tbxml valueOfAttributeNamed:@"correctness" forElement:answer] intValue]]];
				[worksheetQuestionMO addAnswersObject:answerMO];
				answer = [tbxml nextSiblingNamed:@"answer" searchFromElement:answer];
			}
			wQuestion = [tbxml nextSiblingNamed:@"worksheetQuestion" searchFromElement:wQuestion];
		}
		
		[chapterMO setArticle:article];
		[chapterMO setModule:moduleMO];
		[chapterMO setLecture:lectureMO];
		chapter = [tbxml nextSiblingNamed:@"chapter" searchFromElement:chapter];
		 chapterCount++;
	}
	[tbxml release];
	
	//save the managed object
	NSError *error;
	if (![moc save:&error]) {
		NSLog(@"error saving managed object");
		// Handle the error.
	}


}

@end
