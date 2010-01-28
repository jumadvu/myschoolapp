//
//  NewGameHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewGameHome : baseViewController <UITextFieldDelegate> {
	IBOutlet UIButton *continueButton;
	IBOutlet UIButton *avatar1Button;
	IBOutlet UIButton *avatar2Button;
	IBOutlet UITextField *firstField;
	IBOutlet UITextField *lastField;
	int selectedImage;
	NSArray *avatarImages;
}

@property (nonatomic, retain) UIButton *continueButton;
@property (nonatomic, retain) UIButton *avatar1Button;
@property (nonatomic, retain) UIButton *avatar2Button;
@property (nonatomic, retain) UITextField *firstField;
@property (nonatomic, retain) UITextField *lastField;
@property (nonatomic, retain) NSArray *avatarImages;
@property int selectedImage;

-(IBAction)continueAvatarDesign;
-(IBAction)avatarSelected:(UIButton *)sender;

@end
