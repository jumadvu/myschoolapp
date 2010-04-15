//
//  MainMenu.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "MainMenu.h"
#import "GameStatusHome.h"
#import "NewGameHome.h"
#import "HelpHome.h"
#import "LoungeHome.h"
#import "ClassroomHome.h"
#import "StoreHome.h"
#import "LibraryShelves.h"
#import "ParentEmail.h"
#import "User.h"
#import "ActivitiesHome.h"
#import "UserPlus.h"


@implementation MainMenu

@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize loungeButton;
@synthesize libraryButton;
@synthesize classroomButton;
@synthesize storeButton;
@synthesize pointsButton;
@synthesize pointsLabel;
@synthesize teacherAtDesk;

- (void)dealloc {
	[teacherAtDesk release];
	[pointsButton release];
	[pointsLabel release];
	[storeButton release];
	[loungeButton release];
	[libraryButton release];
	[classroomButton release];
	[button1 release];
	[button2 release];
	[button3 release];
	[button4 release];
    [super dealloc];
}

-(void)clickButton1 {
	HelpHome *vc = [[[HelpHome alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}

-(void)pointsButtonClicked {
	GameStatusHome *vc = [[[GameStatusHome alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}

-(void)clickButton3 {
	NewGameHome *vc = [[[NewGameHome alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	delegate.teacher = nil;
	[delegate.navCon pushViewController:vc animated:YES];
}

-(void)loungeButtonClicked {
	LoungeHome *vc = [[[LoungeHome alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}

-(void)activitiesButtonClicked {
	ActivitiesHome *vc = [[[ActivitiesHome alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}

-(void)libraryButtonClicked {
	LibraryShelves *vc = [[[LibraryShelves alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}

-(void)classroomButtonClicked {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	UIActionSheet *actionSheet = [[UIActionSheet alloc]
								  initWithTitle:@""
								  delegate:self
								  cancelButtonTitle:nil
								  destructiveButtonTitle:nil
								  otherButtonTitles:@"Teach Lesson",@"Do Activities", nil];
	[actionSheet showInView:self.view];
	[actionSheet setTag:2];
	[actionSheet release];
	
}

-(void)storeButtonClicked {
	StoreHome *vc = [[[StoreHome alloc] initWithNibName:nil bundle:nil] autorelease];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"main menu view did load");
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
	[self setBackgroundColor];
	[delegate.navCon setNavigationBarHidden:YES];
	[self getParentEmail];
	[self.teacherAtDesk setImage:[delegate.teacher avatarImageWaistUp]];
}

-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	NSLog(@"main menu view did appear");
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	pointsLabel.text = [delegate.teacher.totalPoints stringValue];
}

-(void)getParentEmail {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];

	if ([delegate.parentEmail1 length] < 7 && [delegate.parentEmail2 length] < 7) {
		UIActionSheet *actionSheet = [[UIActionSheet alloc]
									  initWithTitle:@"Your parent(s) would love to know what you're learning in MySchool. If you enter their email address(es) they can receive automatic updates on your progress in the game!"
									  delegate:self
									  cancelButtonTitle:@"Maybe Later"
									  destructiveButtonTitle:@"OK"
									  otherButtonTitles:nil];
		[actionSheet showInView:self.view];
		[actionSheet setTag:1];
		[actionSheet release];
		
	} else {
		NSLog(@"has parent email");
	}

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (actionSheet.tag == 1) {
		//email action sheet
		if (buttonIndex == 0) {
			//get emails
			NSLog(@"get email addresses");
			ParentEmail *vc = [[[ParentEmail alloc] initWithNibName:nil bundle:nil] autorelease];
			MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
			[delegate.navCon pushViewController:vc animated:YES];
			
		} else {
			//do nothing
			NSLog(@"do nothing");
		}
	} else {
		//classroom action sheet
		if (buttonIndex == 0) {
			//to to classroom
			NSLog(@"get email addresses");
			MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
			ClassroomHome *vc = [[[ClassroomHome alloc] initWithNibName:nil bundle:nil] autorelease];
			[delegate.navCon pushViewController:vc animated:YES];
			
		} else {
			//go to activities view
			MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
			ActivitiesHome *vc = [[[ActivitiesHome alloc] initWithNibName:nil bundle:nil] autorelease];
			[delegate.navCon pushViewController:vc animated:YES];
		}
		
	}

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
