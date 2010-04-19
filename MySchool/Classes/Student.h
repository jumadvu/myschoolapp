//
//  Student.h
//  MySchool
//
//  Created by Ashley Kayler on 4/18/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class BehaviorReport;
@class CompletedWorksheet;
@class User;

@interface Student :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * friendliness;
@property (nonatomic, retain) NSNumber * intelligence;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * avatarImage;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSNumber * politeness;
@property (nonatomic, retain) NSDate * lastCheckedReports;
@property (nonatomic, retain) NSNumber * gradeLevel;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * armRaised;
@property (nonatomic, retain) NSSet* reports;
@property (nonatomic, retain) User * teacher;
@property (nonatomic, retain) NSSet* worksheets;

@end


@interface Student (CoreDataGeneratedAccessors)
- (void)addReportsObject:(BehaviorReport *)value;
- (void)removeReportsObject:(BehaviorReport *)value;
- (void)addReports:(NSSet *)value;
- (void)removeReports:(NSSet *)value;

- (void)addWorksheetsObject:(CompletedWorksheet *)value;
- (void)removeWorksheetsObject:(CompletedWorksheet *)value;
- (void)addWorksheets:(NSSet *)value;
- (void)removeWorksheets:(NSSet *)value;

@end

