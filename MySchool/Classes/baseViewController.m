//
//  baseViewController.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "baseViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "HelpHome.h"
#import "PrincipalHelp.h"

@implementation baseViewController

@synthesize mainMenuButton;
@synthesize backButton;
@synthesize helpShowing;

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

-(void) addHelpButton:(int)helpNum x:(int)x y:(int)y {
	
	//create button
	UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom]; 
	UIImage *image = [UIImage imageNamed:@"help.png"];
	myButton.imageView.frame = CGRectMake(0, 0, 25, 25); 
	[myButton setBackgroundImage:image forState:UIControlStateNormal];
	myButton.frame = CGRectMake(x, y, 25, 25);
	myButton.userInteractionEnabled = YES;
	myButton.tag = helpNum;
	[myButton addTarget:self action:@selector(toPrincipalHelp:) forControlEvents:UIControlEventTouchUpInside];  
	
	//add button to view controller
	[self.view addSubview:myButton];
	
}

-(void)toHelp:(UIButton*)sender {
	NSLog(@"help sender tag %d", sender.tag);
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	HelpHome *vc = [[[HelpHome alloc] initWithNibName:nil bundle:nil] autorelease];
	vc.helpNum = [NSNumber numberWithInt:sender.tag];
	[delegate.navCon pushViewController:vc animated:YES];
		
}

- (void)toPrincipalHelp:(UIButton*)sender {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	PrincipalHelp *vc = [[[PrincipalHelp alloc] initWithNibName:nil bundle:nil] autorelease];
	vc.helpNum = [NSNumber numberWithInt:sender.tag];

    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [delegate.navCon presentModalViewController:vc animated:YES];
}

-(void)raiseMenu:(UIButton*)sender {
	
	sender.transform = CGAffineTransformTranslate(sender.transform, 0.0, -30.0);
	
}

-(void)lowerMenu:(UIButton*)sender {
	
	sender.transform = CGAffineTransformIdentity;
	
}
@end
