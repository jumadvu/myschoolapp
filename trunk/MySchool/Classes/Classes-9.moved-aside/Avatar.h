//
//  Avatar.h
//  MySchool
//
//  Created by Ashley Kayler on 3/2/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class User;

@interface Avatar :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * eyes;
@property (nonatomic, retain) NSString * avatarImage;
@property (nonatomic, retain) NSString * nose;
@property (nonatomic, retain) NSString * avatarImageWaistUp;
@property (nonatomic, retain) NSString * hair;
@property (nonatomic, retain) NSString * mouth;
@property (nonatomic, retain) User * user;

@end



