//
//  MainMenu.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainMenu : baseViewController <UIActionSheetDelegate> {
	IBOutlet UIButton *button1;
	IBOutlet UIButton *button2;
	IBOutlet UIButton *button3;
	IBOutlet UIButton *button4;
	IBOutlet UIButton *loungeButton;
	IBOutlet UIButton *libraryButton;
	IBOutlet UIButton *classroomButton;
	IBOutlet UIButton *storeButton;
	IBOutlet UILabel *pointsLabel;
	IBOutlet UILabel *creditsLabel;
	IBOutlet UIButton *pointsButton;
	IBOutlet UIImageView *teacherAtDesk;
}

@property (nonatomic, retain) UIButton *button1;
@property (nonatomic, retain) UIButton *button2;
@property (nonatomic, retain) UIButton *button3;
@property (nonatomic, retain) UIButton *button4;
@property (nonatomic, retain) UIButton *libraryButton;
@property (nonatomic, retain) UIButton *loungeButton;
@property (nonatomic, retain) UIButton *classroomButton;
@property (nonatomic, retain) UIButton *storeButton;
@property (nonatomic, retain) UIButton *pointsButton;
@property (nonatomic, retain) UILabel *pointsLabel;
@property (nonatomic, retain) UILabel *creditsLabel;
@property (nonatomic, retain) UIImageView *teacherAtDesk;

-(IBAction)clickButton1;
-(IBAction)pointsButtonClicked;
-(IBAction)clickButton3;
-(IBAction)loungeButtonClicked;
-(IBAction)libraryButtonClicked;
-(IBAction)activitiesButtonClicked;
-(IBAction)classroomButtonClicked;
-(IBAction)storeButtonClicked;
-(void)getParentEmail;


@end
