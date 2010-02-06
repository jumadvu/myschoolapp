//
//  StudentPlus.h
//  MySchool
//
//  Created by Ashley Kayler on 2/5/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"


@interface Student (StudentPlus) 

+(NSSet*)createStudentsInContext:(NSManagedObjectContext*)context;

@end
