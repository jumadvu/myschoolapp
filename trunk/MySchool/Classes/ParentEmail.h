//
//  ParentEmail.h
//  MySchool
//
//  Created by Ashley Kayler on 3/16/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Chapter;

@interface ParentEmail : baseViewController <UITextFieldDelegate> {
	IBOutlet UITextField *email1;
	IBOutlet UITextField *email2;
	IBOutlet UIButton *button;
	
}

@property (nonatomic, retain) UITextField *email1;
@property (nonatomic, retain) UITextField *email2;
@property (nonatomic, retain) UIButton *button;

-(IBAction)buttonClicked;
+(void)sendEmailForChapter:(Chapter*)chapter;

@end
