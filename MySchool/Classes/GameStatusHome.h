//
//  GameStatusHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GameStatusHome : baseViewController {
	IBOutlet UIButton *button1;
	IBOutlet UIButton *button2;
	IBOutlet UIButton *button3;
	IBOutlet UIButton *button4;
	IBOutlet UIButton *button5;
	IBOutlet UILabel *points;
	IBOutlet UILabel *gradeLevel;
}

@property (nonatomic, retain) UIButton *button1;
@property (nonatomic, retain) UIButton *button2;
@property (nonatomic, retain) UIButton *button3;
@property (nonatomic, retain) UIButton *button4;
@property (nonatomic, retain) UIButton *button5;
@property (nonatomic, retain) UILabel *points;
@property (nonatomic, retain) UILabel *gradeLevel;

-(IBAction)clickButton1;
-(IBAction)clickButton2;
-(IBAction)clickButton3;
-(IBAction)clickButton4;
-(IBAction)clickButton5;

@end
