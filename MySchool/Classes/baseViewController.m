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
	self.view.backgroundColor = [UIColor colorWithRed:.7 green:.85 blue:.85 alpha:1];	
}

-(void)raiseMenu:(UIButton*)sender {
	
	sender.transform = CGAffineTransformTranslate(sender.transform, 0.0, -30.0);
	
	//send it back to original position
	//sender.transform = CGAffineTransformIdentity;
	/*
	NSLog(@"raising menu");
	int newX = sender.frame.origin.x;
	int y = sender.frame.origin.y;
	if (newX>420) {
		newX = newX-1;
	}
	[sender.frame setOrigin:CGMakePoint(newX, y)];
	*/
}

@end
