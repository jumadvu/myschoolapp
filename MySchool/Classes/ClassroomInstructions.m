//
//  ClassroomInstructions.m
//  MySchool
//
//  Created by Ashley Kayler on 4/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "ClassroomInstructions.h"
#import "MySchoolAppDelegate.h"
#import "ClassroomHome.h"


@implementation ClassroomInstructions

@synthesize continueButton;

- (void)dealloc {
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setBackgroundColor];
	[self setTopBarTitle:@"Instructions" withLogo:YES backButton:YES];
}

-(void)continueToLecture {
	ClassroomHome *vc = [[[ClassroomHome alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
	
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
