//
//  WorksheetQuestion.h
//  MySchool
//
//  Created by Ashley Kayler on 2/2/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Worksheet;
@class WorksheetAnswer;

@interface WorksheetQuestion :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Worksheet * worksheet;
@property (nonatomic, retain) NSSet* answers;

@end


@interface WorksheetQuestion (CoreDataGeneratedAccessors)
- (void)addAnswersObject:(WorksheetAnswer *)value;
- (void)removeAnswersObject:(WorksheetAnswer *)value;
- (void)addAnswers:(NSSet *)value;
- (void)removeAnswers:(NSSet *)value;

@end

