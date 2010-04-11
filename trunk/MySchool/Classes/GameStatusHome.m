//
//  GameStatusHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "GameStatusHome.h"
#import "DesignAvatar1.h"
#import "StoreHome.h"
#import "AwardsHome.h"
#import "LessonsTaught.h"
#import "StudentsList.h"
#import "NewGameHome.h"
#import "User.h"

@implementation GameStatusHome

@synthesize button2;
@synthesize button4;
@synthesize button5;
@synthesize points;
@synthesize gradeLevel;
@synthesize approvalLabel;

- (void)dealloc {
	[approvalLabel release];
	[gradeLevel release];
	[points release];
	[button2 release];
	[button4 release];
	[button5 release];
    [super dealloc];
}

-(void)clickButton2 {
	LessonsTaught *vc = [[[LessonsTaught alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}

-(void)clickButton4 {
	NewGameHome *vc = [[[NewGameHome alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}

-(void)clickButton5 {
	AwardsHome *vc = [[[AwardsHome alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
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
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
	[self setBackgroundColor];
	[delegate.navCon setNavigationBarHidden:YES];

}

-(void)viewWillAppear:(BOOL)animated {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if (delegate.teacher.totalPoints == nil) {
		[self.points setText:[NSString stringWithFormat:@"0"]];		
	} else {
		[self.points setText:[NSString stringWithFormat:@"%d", [delegate.teacher.totalPoints intValue]]];
	}
	[self.gradeLevel setText:[NSString stringWithFormat:@"%d", [delegate.teacher.gradeLevel intValue]]];
	[self.approvalLabel setText:[NSString stringWithFormat:@"75%"]];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
