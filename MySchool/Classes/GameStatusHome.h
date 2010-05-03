//
//  GameStatusHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GameStatusHome : baseViewController {
	IBOutlet UIButton *button5;
	IBOutlet UILabel *points;
	IBOutlet UILabel *gradeLevel;
	IBOutlet UILabel *approvalLabel;
}

@property (nonatomic, retain) UIButton *button5;
@property (nonatomic, retain) UILabel *points;
@property (nonatomic, retain) UILabel *gradeLevel;
@property (nonatomic, retain) UILabel *approvalLabel;

-(IBAction)clickButton5;

@end
