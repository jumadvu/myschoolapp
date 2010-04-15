//
//  KeywordSet.h
//  MySchool
//
//  Created by Ashley Kayler on 2/18/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Keyword;
@class Lecture;

@interface KeywordSet :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSSet* words;
@property (nonatomic, retain) Lecture * lecture;

@end


@interface KeywordSet (CoreDataGeneratedAccessors)
- (void)addWordsObject:(Keyword *)value;
- (void)removeWordsObject:(Keyword *)value;
- (void)addWords:(NSSet *)value;
- (void)removeWords:(NSSet *)value;

@end

