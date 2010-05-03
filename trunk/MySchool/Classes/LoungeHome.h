//
//  LoungeHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoungeHome : baseViewController {
	IBOutlet UIButton *button2;
	IBOutlet UIButton *button4;
	IBOutlet UIButton *gradeButton;
	IBOutlet UILabel *numPapersLabel;
	IBOutlet UIButton *gradeBookButton;
	IBOutlet UIView *teacherAtDesk;

}

@property (nonatomic, retain) UIButton *gradeButton;
@property (nonatomic, retain) UILabel *numPapersLabel;
@property (nonatomic, retain) UIButton *gradeBookButton;
@property (nonatomic, retain) UIView *teacherAtDesk;
@property (nonatomic, retain) UIButton *button2;
@property (nonatomic, retain) UIButton *button4;

-(IBAction)toPapersToGrade;
-(IBAction)toStudents;
-(IBAction)clickButton2;
-(IBAction)clickButton4;

@end
