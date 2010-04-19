//
//  BehaviorReport.h
//  MySchool
//
//  Created by Ashley Kayler on 4/18/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Student;

@interface BehaviorReport :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * posNeg;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * correct;
@property (nonatomic, retain) NSString * wrong;
@property (nonatomic, retain) Student * student;

@end



