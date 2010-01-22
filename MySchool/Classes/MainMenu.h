//
//  MainMenu.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainMenu : UIViewController {
	IBOutlet UINavigationController *statusNavController;
	IBOutlet UIButton *button1;
	IBOutlet UIButton *button2;
	IBOutlet UIButton *button3;
	IBOutlet UIButton *button4;

}

@property (nonatomic, retain) UINavigationController *statusNavController;
@property (nonatomic, retain) UIButton *button1;
@property (nonatomic, retain) UIButton *button2;
@property (nonatomic, retain) UIButton *button3;
@property (nonatomic, retain) UIButton *button4;

-(IBAction)clickButton1;
-(IBAction)clickButton2;
-(IBAction)clickButton3;
-(IBAction)clickButton4;

@end
