//
//  Avatar.h
//  MySchool
//
//  Created by Ashley Kayler on 4/27/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class User;

@interface Avatar :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * eyes;
@property (nonatomic, retain) NSString * skin;
@property (nonatomic, retain) NSString * avatarImage;
@property (nonatomic, retain) NSString * clothes;
@property (nonatomic, retain) NSString * avatarImageWaistUp;
@property (nonatomic, retain) NSString * hair;
@property (nonatomic, retain) NSNumber * glasses;
@property (nonatomic, retain) User * user;

@end



