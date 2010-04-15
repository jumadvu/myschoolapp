//
//  Module.h
//  MySchool
//
//  Created by Ashley Kayler on 2/2/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Chapter;

@interface Module :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSNumber * gradeLevel;
@property (nonatomic, retain) NSSet* chapters;

@end


@interface Module (CoreDataGeneratedAccessors)
- (void)addChaptersObject:(Chapter *)value;
- (void)removeChaptersObject:(Chapter *)value;
- (void)addChapters:(NSSet *)value;
- (void)removeChapters:(NSSet *)value;

@end

