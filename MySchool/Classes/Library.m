//
//  Library.m
//  MySchool
//
//  Created by Ashley Kayler on 2/9/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "Library.h"
#import "TBXML.h"
#import "Module.h"
#import "Chapter.h"
#import "Lecture.h"
#import "StudentQuestion.h"
#import "Keyword.h"
#import "KeywordSet.h"
#import "StudentAnswer.h"

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
			xmlFileName = [NSString stringWithFormat:@"2ndGradeModules"];
			break;
		case 3:
			xmlFileName = [NSString stringWithFormat:@"3rdGradeModules"];
			break;
		default:
			break;
	}
	return xmlFileName;
	
}

+(void)addXMLModule:(NSString*)xmlFile toDatabaseContext:(NSManagedObjectContext*)moc {
	Module *moduleMO = (Module *)[NSEntityDescription insertNewObjectForEntityForName:@"Module" inManagedObjectContext:moc];
	TBXML * tbxml = [[TBXML alloc] initWithXMLFile:xmlFile fileExtension:@"xml"];
	TBXMLElement * root = tbxml.rootXMLElement;
	TBXMLElement * module = [tbxml childElementNamed:@"module" parentElement:root];
	[moduleMO setTitle:[tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:module]]];
	[moduleMO setGradeLevel:[NSNumber numberWithInt:[[tbxml textForElement:[tbxml childElementNamed:@"gradeLevel" parentElement:module]] intValue]]];
	[moduleMO setSubject:[tbxml textForElement:[tbxml childElementNamed:@"superSubject" parentElement:module]]];
	
	//grab each chapter
	TBXMLElement * chapter=[tbxml childElementNamed:@"chapter" parentElement:module];
	while (chapter!=nil){
		Chapter *chapterMO = (Chapter *)[NSEntityDescription insertNewObjectForEntityForName:@"Chapter" inManagedObjectContext:moc];
		Lecture *lectureMO = (Lecture *)[NSEntityDescription insertNewObjectForEntityForName:@"Lecture" inManagedObjectContext:moc];
		TBXMLElement * lecture=[tbxml childElementNamed:@"lecture" parentElement:chapter];
		[lectureMO setTitle:[tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:lecture]]];
		[lectureMO setText:[tbxml textForElement:[tbxml childElementNamed:@"text" parentElement:lecture]]];
		[lectureMO setChapter:chapterMO];

		//get the keyword sets
		TBXMLElement * keywordSet=[tbxml childElementNamed:@"keywordSet" parentElement:chapter];		
		while (keywordSet!=nil) {
			KeywordSet *keySetMO = (KeywordSet *)[NSEntityDescription insertNewObjectForEntityForName:@"KeywordSet" inManagedObjectContext:moc];
			[keySetMO setCorrectWord:[tbxml valueOfAttributeNamed:@"word" forElement:keywordSet]];
			[keySetMO setLecture:lectureMO];
			TBXMLElement * word=[tbxml childElementNamed:@"word" parentElement:keywordSet];		
			while (word!=nil) {
				Keyword *wordMO = (Keyword *)[NSEntityDescription insertNewObjectForEntityForName:@"Keyword" inManagedObjectContext:moc];
				[wordMO setWord:[tbxml textForElement:[tbxml childElementNamed:@"word" parentElement:keywordSet]]];
				[keySetMO addWordsObject:wordMO];
				word = [tbxml nextSiblingNamed:@"word" searchFromElement:word];
			}
			keywordSet = [tbxml nextSiblingNamed:@"keywordSet" searchFromElement:keywordSet];
		}
		
		//grab the student questions
		TBXMLElement * studentQ=[tbxml childElementNamed:@"studentQuestion" parentElement:chapter];		
		while (studentQ!=nil) {
			StudentQuestion *studentQMO = (StudentQuestion *)[NSEntityDescription insertNewObjectForEntityForName:@"StudentQuestion" inManagedObjectContext:moc];
			[studentQMO setText:[tbxml textForElement:[tbxml childElementNamed:@"text" parentElement:studentQ]]];
			[studentQMO setStudentType:[NSNumber numberWithInt:[[tbxml textForElement:[tbxml childElementNamed:@"studentType" parentElement:studentQ]] intValue]]];
			[studentQMO setLecture:lectureMO];
			TBXMLElement * answer=[tbxml childElementNamed:@"answer" parentElement:studentQ];		
			while (answer!=nil) {
				StudentAnswer *answerMO = (StudentAnswer *)[NSEntityDescription insertNewObjectForEntityForName:@"StudentAnswer" inManagedObjectContext:moc];
				[answerMO setAnswer:[tbxml textForElement:[tbxml childElementNamed:@"answer" parentElement:studentQ]]];
				[answerMO setCorrectness:[NSNumber numberWithInt:[[tbxml valueOfAttributeNamed:@"correctness" forElement:answer] intValue]]];
				[studentQMO addAnswersObject:answerMO];
				answer = [tbxml nextSiblingNamed:@"answer" searchFromElement:answer];
			}
			studentQ = [tbxml nextSiblingNamed:@"studentQuestion" searchFromElement:studentQ];
		}
		
		
		[chapterMO setTitle:[tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:chapter]]];
		[chapterMO setOverview:[tbxml textForElement:[tbxml childElementNamed:@"article" parentElement:chapter]]];
		[chapterMO setModule:moduleMO];
		[chapterMO setLecture:lectureMO];
		chapter = [tbxml nextSiblingNamed:@"chapter" searchFromElement:chapter];
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
