//
//  ChapterPlus.h
//  MySchool
//
//  Created by Ashley Kayler on 2/22/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chapter.h"

@interface Chapter (ChapterPlus) 

- (NSNumber*)maxPointsForUsersCompletedLessons:(NSArray*)completedLessons;
- (NSString*)maxPointsForUsersCompletedLessonsAsString:(NSArray*)completedLessons;
-(NSArray*)studentQuestionsArray;
- (NSData*)createFormData:(NSDictionary*)myDictionary withBoundary:(NSString*)myBounds;
- (void)sendEmail;
-(NSString*)emailMessage;


@end
