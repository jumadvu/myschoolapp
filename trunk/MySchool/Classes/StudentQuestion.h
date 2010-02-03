//
//  StudentQuestion.h
//  MySchool
//
//  Created by Ashley Kayler on 2/2/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Lecture;
@class StudentAnswer;

@interface StudentQuestion :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * studentType;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSSet* answers;
@property (nonatomic, retain) Lecture * lecture;

@end


@interface StudentQuestion (CoreDataGeneratedAccessors)
- (void)addAnswersObject:(StudentAnswer *)value;
- (void)removeAnswersObject:(StudentAnswer *)value;
- (void)addAnswers:(NSSet *)value;
- (void)removeAnswers:(NSSet *)value;

@end

