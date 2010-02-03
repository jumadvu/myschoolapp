//
//  WorksheetAnswer.h
//  MySchool
//
//  Created by Ashley Kayler on 2/2/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class WorksheetQuestion;

@interface WorksheetAnswer :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * answer;
@property (nonatomic, retain) NSNumber * correctness;
@property (nonatomic, retain) WorksheetQuestion * question;

@end



