//
//  Library.m
//  MySchool
//
//  Created by Ashley Kayler on 2/9/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "Library.h"
#import "TBXML.h"


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

@end
