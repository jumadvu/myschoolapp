//
//  Chapter.h
//  MySchool
//
//  Created by Ashley Kayler on 4/14/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Article;
@class CompletedLesson;
@class Lecture;
@class Module;

@interface Chapter :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * overview;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Lecture * lecture;
@property (nonatomic, retain) NSSet* completedLessons;
@property (nonatomic, retain) Article * article;
@property (nonatomic, retain) Module * module;

@end


@interface Chapter (CoreDataGeneratedAccessors)
- (void)addCompletedLessonsObject:(CompletedLesson *)value;
- (void)removeCompletedLessonsObject:(CompletedLesson *)value;
- (void)addCompletedLessons:(NSSet *)value;
- (void)removeCompletedLessons:(NSSet *)value;

@end

