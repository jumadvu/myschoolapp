//
//  StudentAnswer.h
//  MySchool
//
//  Created by Ashley Kayler on 1/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class StudentQuestion;

@interface StudentAnswer :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSNumber * correctness;
@property (nonatomic, retain) StudentQuestion * question;

@end



