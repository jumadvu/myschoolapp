//
//  Module.h
//  MySchool
//
//  Created by Ashley Kayler on 4/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Chapter;
@class User;

@interface Module :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSNumber * gradeLevel;
@property (nonatomic, retain) NSSet* chapters;
@property (nonatomic, retain) User * currentUser;

@end


@interface Module (CoreDataGeneratedAccessors)
- (void)addChaptersObject:(Chapter *)value;
- (void)removeChaptersObject:(Chapter *)value;
- (void)addChapters:(NSSet *)value;
- (void)removeChapters:(NSSet *)value;

@end

