//
//  UserPlus.h
//  MySchool
//
//  Created by Ashley Kayler on 2/1/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface User (UserPlus)

-(NSString *)fullName;
-(UIImage *)avatarImage;
-(UIImage *)avatarImageWaistUp;
-(NSArray*)studentsArray;
-(NSString*)title;
-(NSArray*)ungradedPapers;
-(NSNumber*)pointsAvailable;
-(void) adjustApprovalRating:(NSNumber*)value;

@end
