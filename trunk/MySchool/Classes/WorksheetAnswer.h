//
//  WorksheetAnswer.h
//  MySchool
//
//  Created by Ashley Kayler on 4/14/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class CompletedWorksheet;
@class WorksheetQuestion;

@interface WorksheetAnswer :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSNumber * correctness;
@property (nonatomic, retain) NSSet* completedWorksheets;
@property (nonatomic, retain) WorksheetQuestion * question;

@end


@interface WorksheetAnswer (CoreDataGeneratedAccessors)
- (void)addCompletedWorksheetsObject:(CompletedWorksheet *)value;
- (void)removeCompletedWorksheetsObject:(CompletedWorksheet *)value;
- (void)addCompletedWorksheets:(NSSet *)value;
- (void)removeCompletedWorksheets:(NSSet *)value;

@end

