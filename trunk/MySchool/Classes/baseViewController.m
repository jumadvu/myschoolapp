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

-(void)setTopBarTitle:(NSString*)title withLogo:(BOOL)addLogo backButton:(BOOL)addBackButton {

	//add topbar
	UIImage *topbarImage = [UIImage imageNamed:@"topbar.png"];
	UIImageView * topbarImageView = [[UIImageView alloc] initWithImage:topbarImage];
	topbarImageView.frame = CGRectMake(0, 0, topbarImage.size.width, topbarImage.size.height);
	[self.view addSubview:topbarImageView];

	//add title label
	if (title != nil) {
		UILabel * pageTitle = [[UILabel alloc] initWithFrame:CGRectZero];
		pageTitle.frame = CGRectMake(60.0, 10.0, 200.0, 25.0);
		pageTitle.backgroundColor = [UIColor clearColor];
		pageTitle.font = [UIFont boldSystemFontOfSize:17];
		pageTitle.textAlignment = UITextAlignmentCenter;
		pageTitle.textColor = [UIColor whiteColor];
		pageTitle.adjustsFontSizeToFitWidth = YES;
		pageTitle.text = title;
		[self.view addSubview:pageTitle];
	}
	
	//add back button
	if (addBackButton) {
		backButton = [UIButton buttonWithType:UIButtonTypeCustom]; 
		UIImage *image = [UIImage imageNamed:@"chalk_back.png"];
		backButton.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height); 
		backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self.backButton setBackgroundImage:image forState:UIControlStateNormal];
		backButton.frame = CGRectMake(5, 10, 40, 30);
		[self.backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];  
		[self.view addSubview:backButton];
	}
	
	//add topbar
	if (addLogo) {
		mainMenuButton = [UIButton buttonWithType:UIButtonTypeCustom]; 
		UIImage *image = [UIImage imageNamed:@"logo2.png"];
		mainMenuButton.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height); 
		mainMenuButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self.mainMenuButton setBackgroundImage:image forState:UIControlStateNormal];
		mainMenuButton.frame = CGRectMake(263, 5, 50, 25);
		[self.mainMenuButton addTarget:self action:@selector(toMainMenu) forControlEvents:UIControlEventTouchUpInside];  
		[self.view addSubview:mainMenuButton];
	}
	
}

-(void)raiseMenu:(UIButton*)sender {
	
	sender.transform = CGAffineTransformTranslate(sender.transform, 0.0, -30.0);
	
}

-(void)lowerMenu:(UIButton*)sender {
	
	sender.transform = CGAffineTransformIdentity;
	
}
@end
