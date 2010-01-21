//
//  User.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface User :  NSManagedObject  
{
}

@property (nonatomic, retain) id avatarImage;
@property (nonatomic, retain) NSString * firstName;

@end



