//
//  Student.h
//  MySchool
//
//  Created by Ashley Kayler on 2/2/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class CompletedWorksheet;
@class User;

@interface Student :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * gradeLevel;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) id avatarImage;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSSet* worksheets;
@property (nonatomic, retain) User * teacher;

@end


@interface Student (CoreDataGeneratedAccessors)
- (void)addWorksheetsObject:(CompletedWorksheet *)value;
- (void)removeWorksheetsObject:(CompletedWorksheet *)value;
- (void)addWorksheets:(NSSet *)value;
- (void)removeWorksheets:(NSSet *)value;

@end

