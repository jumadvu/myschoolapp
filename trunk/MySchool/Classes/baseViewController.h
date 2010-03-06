//
//  baseViewController.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface baseViewController : UIViewController {
	IBOutlet UIButton *mainMenuButton;
	IBOutlet UIButton *backButton;

}

@property (nonatomic, retain) UIButton *mainMenuButton;
@property (nonatomic, retain) UIButton *backButton;

-(IBAction)toMainMenu;
-(IBAction)raiseMenu:(UIButton*)sender;
-(IBAction)lowerMenu:(UIButton*)sender;
-(IBAction)goBack;
-(void)setBackgroundColor;

@end
