//
//  ClassroomDesk.m
//  MySchool
//
//  Created by Ashley Kayler on 4/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "ClassroomDesk.h"
#import "User.h"
#import "LibraryShelves.h"
#import "UserPlus.h"
#import "ModuleHome.h"

@implementation ClassroomDesk

@synthesize teacherAtDesk;

- (void)dealloc {
	[teacherAtDesk release];
    [super dealloc];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	if (delegate.teacher.currentModule == nil) {
		//go to library to choose module
		LibraryShelves *vc = [[[LibraryShelves alloc] initWithNibName:nil bundle:nil] autorelease];
		[delegate.navCon pushViewController:vc animated:YES];	
		
		NSString *msg = [NSString stringWithFormat:@"First let's go to the library to choose a lesson to teach."];
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Wait a second." 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
	[self setTopBarTitle:@"Classroom" withLogo:YES backButton:YES];
	[self.teacherAtDesk setImage:[delegate.teacher avatarImageWaistUp]];
	
	//NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
	[NSTimer scheduledTimerWithTimeInterval:2 target:self 
								   selector:@selector(stopIt) userInfo:nil repeats:NO];
}

-(void)stopIt {
	NSLog(@"timer fired");
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(moveOn)];
	self.view.transform = CGAffineTransformMakeScale(4.3,4.3);
	[UIView commitAnimations];

}

-(void)moveOn {
	
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ModuleHome *vc = [[[ModuleHome alloc] initWithNibName:nil bundle:nil] autorelease];
	vc.targetModule= delegate.teacher.currentModule;
	vc.goToLearn = NO;
	[delegate.navCon pushViewController:vc animated:YES];	
	
}
/*
- (void)timerFireMethod:(NSTimer*)theTimer {
	NSLog(@"timer fired");
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
