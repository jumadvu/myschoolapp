//
//  CompletedLesson.h
//  MySchool
//
//  Created by Ashley Kayler on 1/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Chapter;
@class User;

@interface CompletedLesson :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) NSNumber * points;
@property (nonatomic, retain) Chapter * chapter;
@property (nonatomic, retain) User * user;

@end



