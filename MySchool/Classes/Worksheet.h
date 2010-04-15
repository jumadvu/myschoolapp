//
//  Worksheet.h
//  MySchool
//
//  Created by Ashley Kayler on 4/14/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class CompletedWorksheet;
@class Lecture;
@class User;
@class WorksheetQuestion;

@interface Worksheet :  NSManagedObject  
{
}

@property (nonatomic, retain) NSSet* questions;
@property (nonatomic, retain) NSSet* completedWorksheets;
@property (nonatomic, retain) User * user;
@property (nonatomic, retain) Lecture * lecture;

@end


@interface Worksheet (CoreDataGeneratedAccessors)
- (void)addQuestionsObject:(WorksheetQuestion *)value;
- (void)removeQuestionsObject:(WorksheetQuestion *)value;
- (void)addQuestions:(NSSet *)value;
- (void)removeQuestions:(NSSet *)value;

- (void)addCompletedWorksheetsObject:(CompletedWorksheet *)value;
- (void)removeCompletedWorksheetsObject:(CompletedWorksheet *)value;
- (void)addCompletedWorksheets:(NSSet *)value;
- (void)removeCompletedWorksheets:(NSSet *)value;

@end

