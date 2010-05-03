//
//  Library.h
//  MySchool
//
//  Created by Ashley Kayler on 2/9/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
@class PersonalQuestion;

@interface Library : NSObject {
}


+(NSArray*)subjectsForGrade:(NSNumber *)gradeLevel;
+(NSString*) whichXMLFile:(NSNumber*)gradeLevel;
+(void)addXMLModule:(NSString*)xmlFile toDatabaseContext:(NSManagedObjectContext*)moc;
+(NSArray*)fetchModulesFromDBforGrade:(NSNumber*)gradeLevel;
+(void)addBehaviorReports:(NSString*)xmlFile toDatabaseContext:(NSManagedObjectContext*)moc;
+(NSArray*)fetchBehaviorReports:(NSString*)type;
+(NSArray*)getHelp;
+(void)addPersonalQuestionsToDatabaseContext:(NSManagedObjectContext*)moc;
+(PersonalQuestion*)fetchPersonalQuestion;

@end
