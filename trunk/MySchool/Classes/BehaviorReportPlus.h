//
//  BehaviorReportPlus.h
//  MySchool
//
//  Created by Ashley Kayler on 4/19/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BehaviorReport.h"

@interface BehaviorReport (BehaviorReportPlus) 

+(NSString *)replaceName:(NSString*)name gender:(NSString*)gender inText:(NSString*)sometext;

@end
