//
//  GradePaper.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompletedWorksheet;

@interface GradePaper : UITableViewController <UIAlertViewDelegate> {
	NSArray *answers;
	NSArray *completedWorksheets;
	CompletedWorksheet *completedWorksheet;
	NSMutableArray *answersGradedArray;
	UILabel *gradeLabel;
	int currentPaper;
}

@property (nonatomic, retain) NSArray *answers;
@property (nonatomic, retain) NSArray *completedWorksheets;
@property (nonatomic, retain) CompletedWorksheet *completedWorksheet;
@property (nonatomic, retain) NSMutableArray *answersGradedArray;
@property (nonatomic, retain) UILabel *gradeLabel;
@property (nonatomic) int currentPaper;

-(void)goBackwards:(id)sender;
-(void)goNext;
-(void)gradedQuestion:(NSNumber*)row value:(NSNumber*)value;

@end
