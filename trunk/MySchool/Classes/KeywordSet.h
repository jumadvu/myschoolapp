//
//  KeywordSet.h
//  MySchool
//
//  Created by Ashley Kayler on 1/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Keyword;
@class Lecture;

@interface KeywordSet :  NSManagedObject  
{
}

@property (nonatomic, retain) Lecture * lecture;
@property (nonatomic, retain) NSSet* words;

@end


@interface KeywordSet (CoreDataGeneratedAccessors)
- (void)addWordsObject:(Keyword *)value;
- (void)removeWordsObject:(Keyword *)value;
- (void)addWords:(NSSet *)value;
- (void)removeWords:(NSSet *)value;

@end

