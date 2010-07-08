//
//  WorksheetPlus.h
//  MySchool
//
//  Created by Ashley Kayler on 3/4/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Worksheet.h"

@interface Worksheet (WorksheetPlus)

+(void)createCompletedWorksheetsForTeacher:(User*)teacher forChapter:(Chapter*)chapter withPoints:(int)lectureScore;

@end
