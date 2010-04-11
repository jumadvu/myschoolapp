//
//  Rating.h
//  MySchool
//
//  Created by Ashley Kayler on 4/11/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class User;

@interface Rating :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) User * teacher;

@end



