//
//  User.h
//  MySchool
//
//  Created by Ashley Kayler on 3/17/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Avatar;
@class CompletedLesson;
@class Student;
@class UserAwards;
@class Worksheet;

@interface User :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * gradeLevel;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * totalPoints;
@property (nonatomic, retain) NSSet* purchases;
@property (nonatomic, retain) NSSet* completedLessons;
@property (nonatomic, retain) NSSet* userAwards;
@property (nonatomic, retain) NSSet* students;
@property (nonatomic, retain) Avatar * avatar;
@property (nonatomic, retain) NSSet* worksheets;

@end


@interface User (CoreDataGeneratedAccessors)
- (void)addPurchasesObject:(NSManagedObject *)value;
- (void)removePurchasesObject:(NSManagedObject *)value;
- (void)addPurchases:(NSSet *)value;
- (void)removePurchases:(NSSet *)value;

- (void)addCompletedLessonsObject:(CompletedLesson *)value;
- (void)removeCompletedLessonsObject:(CompletedLesson *)value;
- (void)addCompletedLessons:(NSSet *)value;
- (void)removeCompletedLessons:(NSSet *)value;

- (void)addUserAwardsObject:(UserAwards *)value;
- (void)removeUserAwardsObject:(UserAwards *)value;
- (void)addUserAwards:(NSSet *)value;
- (void)removeUserAwards:(NSSet *)value;

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet *)value;
- (void)removeStudents:(NSSet *)value;

- (void)addWorksheetsObject:(Worksheet *)value;
- (void)removeWorksheetsObject:(Worksheet *)value;
- (void)addWorksheets:(NSSet *)value;
- (void)removeWorksheets:(NSSet *)value;

@end

