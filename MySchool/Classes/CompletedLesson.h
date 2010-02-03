//
//  CompletedLesson.h
//  MySchool
//
//  Created by Ashley Kayler on 2/2/10.
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
@property (nonatomic, retain) User * user;
@property (nonatomic, retain) Chapter * chapter;

@end



