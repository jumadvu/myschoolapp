//
//  StudentPlus.h
//  MySchool
//
//  Created by Ashley Kayler on 2/5/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"


@interface Student (StudentPlus) 

+(NSSet*)createStudentsInContext:(NSManagedObjectContext*)context;

-(UIImage *)frontView;
-(UIImage *)frontViewForMood:(NSString*)mood;
-(NSArray*)wavingImageView;
-(BOOL)hasQuestion;
-(void)setImageView:(UIImageView*)basicView forMood:(NSString*)mood isWaving:(BOOL)waving;
-(NSArray*)completedWorksheetsArray;
-(NSString*)overallGrade;

@end
