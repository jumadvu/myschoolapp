//
//  baseViewController.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "baseViewController.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation baseViewController

@synthesize mainMenuButton;
@synthesize backButton;

-(void)toMainMenu {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon popToRootViewControllerAnimated:YES];		
}


-(void)goBack {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon popViewControllerAnimated:YES];		
	
}

-(void)setBackgroundColor {
	self.view.backgroundColor = [UIColor colorWithRed:.99 green:.98 blue:.82 alpha:1];	
}

-(void)raiseMenu:(UIButton*)sender {
	
	sender.transform = CGAffineTransformTranslate(sender.transform, 0.0, -30.0);
	
}

-(void)lowerMenu:(UIButton*)sender {
	
	sender.transform = CGAffineTransformIdentity;
	
}

@end
