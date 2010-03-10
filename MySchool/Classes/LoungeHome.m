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

@implementation LoungeHome

@synthesize gradeButton;
@synthesize numPapersLabel;

- (void)dealloc {
	[numPapersLabel release];
	[gradeButton release];
    [super dealloc];
}


-(void)toPapersToGrade {
	//go back to previous page
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	GradePaper *vc = [[[GradePaper alloc] initWithStyle:UITableViewStylePlain] autorelease];
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

- (void)viewDidAppear:(BOOL)animated {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[self.numPapersLabel setText:[[NSNumber numberWithInt:[[delegate.teacher ungradedPapers] count]] stringValue]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"lounge view did load");
    [super viewDidLoad];
	[self setBackgroundColor];
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
