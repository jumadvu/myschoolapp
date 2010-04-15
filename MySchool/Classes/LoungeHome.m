//
//  LoungeHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "LoungeHome.h"
#import "GradePaper.h"
#import "User.h"
#import "UserPlus.h"
#import "StudentsList.h"

@implementation LoungeHome

@synthesize gradeButton;
@synthesize numPapersLabel;
@synthesize gradeBookButton;
@synthesize teacherAtDesk;

- (void)dealloc {
	//[numPapersLabel release];
	[teacherAtDesk release];
	[gradeButton release];
    [super dealloc];
}

-(void)toStudents {
	StudentsList *vc = [[[StudentsList alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}

-(void)toPapersToGrade {
	//go back to previous page
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if ([[delegate.teacher ungradedPapers] count] < 1) {
		NSString *msg = [NSString stringWithFormat:@"You may want to prepare for your next class."];
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"You have no papers to grade at this time." 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	} else {
		GradePaper *vc = [[[GradePaper alloc] initWithStyle:UITableViewStylePlain] autorelease];
		[delegate.navCon pushViewController:vc animated:YES];
	}

	
}

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidAppear:(BOOL)animated {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[self.numPapersLabel setText:[[NSNumber numberWithInt:[[delegate.teacher ungradedPapers] count]] stringValue]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"lounge view did load");
    [super viewDidLoad];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[self setTopBarTitle:@"My Office" withLogo:YES backButton:YES];
	[self.teacherAtDesk setImage:[delegate.teacher avatarImageWaistUp]];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	NSLog(@"lounge home view did unload");
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



@end
