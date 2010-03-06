//
//  GradePaper.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompletedWorksheet;

@interface GradePaper : UITableViewController {
	NSArray *answers;
	CompletedWorksheet *completedWorksheet;
}

@property (nonatomic, retain) NSArray *answers;
@property (nonatomic, retain) CompletedWorksheet *completedWorksheet;

-(void)goBack;
-(void)goNext;

@end
