//
//  ParentEmail.m
//  MySchool
//
//  Created by Ashley Kayler on 3/16/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "ParentEmail.h"
#import "MySchoolAppDelegate.h"
#import "Chapter.h"
#import "ChapterPlus.h"

@implementation ParentEmail

@synthesize email1;
@synthesize email2;
@synthesize button;

- (void)dealloc {
    [email1 release];
	[email2 release];
	[button release];
	[super dealloc];
}

-(void)buttonClicked {
	NSLog(@"save email addresses");
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	delegate.parentEmail1 = email1.text;
	delegate.parentEmail2 = email2.text;
	//save data in plist
	[delegate savingDataToPlist];
	[delegate.navCon popToRootViewControllerAnimated:YES];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self setBackgroundColor];
	[self setTopBarTitle:@"Parent Email" withLogo:NO backButton:NO];
	[email1 setDelegate:self];
	[email2 setDelegate:self];
    [super viewDidLoad];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSLog(@"return");
	[textField resignFirstResponder];
	//if (textField == firstNameField) {
	//[firstNameField resignFirstResponder];
	//[self save];
	//}
	return YES;
}

+(void)sendEmailForChapter:(Chapter*)chapter{
	//user completed a lecture. prep the parents via email
	[chapter sendEmail];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}




@end
