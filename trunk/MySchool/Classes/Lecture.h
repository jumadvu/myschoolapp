//
//  Lecture.h
//  MySchool
//
//  Created by Ashley Kayler on 1/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Chapter;
@class KeywordSet;
@class StudentQuestion;

@interface Lecture :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Chapter * chapter;
@property (nonatomic, retain) NSSet* studentQuestions;
@property (nonatomic, retain) NSSet* keywordSets;

@end


@interface Lecture (CoreDataGeneratedAccessors)
- (void)addStudentQuestionsObject:(StudentQuestion *)value;
- (void)removeStudentQuestionsObject:(StudentQuestion *)value;
- (void)addStudentQuestions:(NSSet *)value;
- (void)removeStudentQuestions:(NSSet *)value;

- (void)addKeywordSetsObject:(KeywordSet *)value;
- (void)removeKeywordSetsObject:(KeywordSet *)value;
- (void)addKeywordSets:(NSSet *)value;
- (void)removeKeywordSets:(NSSet *)value;

@end

