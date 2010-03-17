//
//  StoreItem.h
//  MySchool
//
//  Created by Ashley Kayler on 3/17/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Image;
@class User;

@interface StoreItem :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSSet* teachers;
@property (nonatomic, retain) Image * image;

@end


@interface StoreItem (CoreDataGeneratedAccessors)
- (void)addTeachersObject:(User *)value;
- (void)removeTeachersObject:(User *)value;
- (void)addTeachers:(NSSet *)value;
- (void)removeTeachers:(NSSet *)value;

@end

