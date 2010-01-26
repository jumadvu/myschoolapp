//
//  Worksheet.h
//  MySchool
//
//  Created by Ashley Kayler on 1/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Lecture;
@class User;
@class WorksheetQuestion;

@interface Worksheet :  NSManagedObject  
{
}

@property (nonatomic, retain) NSSet* questions;
@property (nonatomic, retain) Lecture * lecture;
@property (nonatomic, retain) User * user;

@end


@interface Worksheet (CoreDataGeneratedAccessors)
- (void)addQuestionsObject:(WorksheetQuestion *)value;
- (void)removeQuestionsObject:(WorksheetQuestion *)value;
- (void)addQuestions:(NSSet *)value;
- (void)removeQuestions:(NSSet *)value;

@end

