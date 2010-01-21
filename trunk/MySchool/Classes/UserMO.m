//
//  UserMO.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "UserMO.h"


@implementation UserMO

-(NSString *)fullName {
	return [NSString stringWithFormat:@"%@ Smith", self.firstName];
}
@end
