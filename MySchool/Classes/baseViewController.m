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

-(void)toMainMenu {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon popToRootViewControllerAnimated:YES];		
}

@end
