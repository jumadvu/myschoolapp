//
//  baseViewController.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "baseViewController.h"


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

@end