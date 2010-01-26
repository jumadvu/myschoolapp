//
//  Award.h
//  MySchool
//
//  Created by Ashley Kayler on 1/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class UserAwards;

@interface Award :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet* userAwards;

@end


@interface Award (CoreDataGeneratedAccessors)
- (void)addUserAwardsObject:(UserAwards *)value;
- (void)removeUserAwardsObject:(UserAwards *)value;
- (void)addUserAwards:(NSSet *)value;
- (void)removeUserAwards:(NSSet *)value;

@end

