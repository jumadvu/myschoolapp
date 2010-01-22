//
//  LoginController.h
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright DataJedi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : baseViewController {
	IBOutlet UIButton *newAccountButton;
	NSMutableArray *users;
	IBOutlet UIButton *imageButton;
}

@property (nonatomic, retain) UIButton *newAccountButton;
@property (nonatomic, retain) UIButton *imageButton;

-(IBAction) toNewAccount;

@end

