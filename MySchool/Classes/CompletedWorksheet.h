//
//  CompletedWorksheet.h
//  MySchool
//
//  Created by Ashley Kayler on 1/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Student;
@class Worksheet;
@class WorksheetAnswer;

@interface CompletedWorksheet :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * grade;
@property (nonatomic, retain) Student * student;
@property (nonatomic, retain) Worksheet * worksheet;
@property (nonatomic, retain) NSSet* answers;

@end


@interface CompletedWorksheet (CoreDataGeneratedAccessors)
- (void)addAnswersObject:(WorksheetAnswer *)value;
- (void)removeAnswersObject:(WorksheetAnswer *)value;
- (void)addAnswers:(NSSet *)value;
- (void)removeAnswers:(NSSet *)value;

@end

