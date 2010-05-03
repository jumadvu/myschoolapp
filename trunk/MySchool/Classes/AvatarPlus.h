//
//  AvatarPlus.h
//  MySchool
//
//  Created by Ashley Kayler on 4/27/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Avatar.h"

@interface Avatar (AvatarPlus) 

-(UIView*)customAvatarAtSize:(float)scale;
-(void)setGenericMan;
-(void)setGenericWoman;

@end
