//
//  HandleReport.h
//  MySchool
//
//  Created by Ashley Kayler on 4/19/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BehaviorReport;
@class StudentReports;

@interface HandleReport : UIViewController {
	IBOutlet UIImageView *teacherAtDesk;
	BehaviorReport *report;
	BOOL answer1Correct;
	StudentReports *delegate;

}
@property (nonatomic, retain) UIImageView *teacherAtDesk;
@property (nonatomic, retain) BehaviorReport *report;
@property (nonatomic) BOOL answer1Correct;
@property (nonatomic, retain) StudentReports *delegate;

@end
