//
//  UserAwards.h
//  MySchool
//
//  Created by Ashley Kayler on 2/2/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Award;
@class User;

@interface UserAwards :  NSManagedObject  
{
}

@property (nonatomic, retain) Award * award;
@property (nonatomic, retain) User * user;

@end



