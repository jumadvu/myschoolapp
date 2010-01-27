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

@implementation GameStatusHome

@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize button5;

- (void)dealloc {
	[button1 release];
	[button2 release];
	[button3 release];
	[button4 release];
	[button5 release];
    [super dealloc];
}

-(void)clickButton1 {
	StoreHome *vc = [[[StoreHome alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}

-(void)clickButton2 {
	LessonsTaught *vc = [[[LessonsTaught alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}

-(void)clickButton3 {
	StudentsList *vc = [[[StudentsList alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}

-(void)clickButton4 {
	DesignAvatar1 *vc = [[[DesignAvatar1 alloc] initWithNibName:nil bundle:nil] autorelease];
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
