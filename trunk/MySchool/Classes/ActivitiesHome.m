//
//  ActivitiesHome.m
//  MySchool
//
//  Created by Ashley Kayler on 4/10/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "ActivitiesHome.h"
#import "MySchoolAppDelegate.h"
#import "User.h"
#import "MainMenu.h"
#import "StoreItem.h"
#import "Image.h"
#import "MusicMenu.h"
#import "DayinHistory.h"

@implementation ActivitiesHome

@synthesize scroller;
@synthesize activities;

- (void)dealloc {
	[activities release];
	[scroller release];
    [super dealloc];
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
    [super viewDidLoad];
	[self setTopBarTitle:@"Fun Zone Activities" withLogo:YES backButton:YES];
	[self setBackgroundColor];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[self setActivities:[delegate.teacher.purchases allObjects]];
	if ([activities count] == 0) {
		//they don't have any purchases yet, show an alert.
		NSString *msg;
		if ([delegate.teacher.totalPoints intValue] < 200) {
			msg = [NSString stringWithFormat:@"You don't have any activities for your classroom yet. You get activities at the School Store. But first, you need to earn some teaching points by teaching some lessons."];
		} else {
			msg = [NSString stringWithFormat:@"You don't have any activities for your classroom yet. You can trade in teaching points for activities at the School Store."];
		}

		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"No activities!" 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		MainMenu *vc = [[[MainMenu alloc] initWithNibName:nil bundle:nil] autorelease];
		[delegate.navCon pushViewController:vc animated:YES];	

	}

	//set up scroller
	
	scroller.backgroundColor = [UIColor clearColor];
	int spacer = 160;
	int x = 0;
	for (int i = 0; i< [activities count]; i++) {
		
		StoreItem *activity = [activities objectAtIndex:i];
		UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom]; 
		UIImage *image = [UIImage imageNamed:[[activity image] fileName]];
		myButton.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height); 
		myButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
		[myButton setBackgroundImage:image forState:UIControlStateNormal];
		myButton.frame = CGRectMake((i*spacer)+90, 120, 90, 75);
		myButton.tag = i;
		[myButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];  
		
		//add a counter section for every other activity
		if (i%2 == 0) {
			UIImage *counterImage = [UIImage imageNamed:@"counter.png"];
			UIImageView * counterImageView = [[UIImageView alloc] initWithImage:counterImage];
			counterImageView.contentMode = UIViewContentModeScaleAspectFit;
			counterImageView.frame = CGRectMake(i*spacer, 182, counterImage.size.width, counterImage.size.height);
			[scroller addSubview:counterImageView];
		}
				
		[scroller addSubview:myButton];
		x = i;
	}
	//add last counter piece if even number of activities
	if (x%2 != 0) {
		UIImage *counterImage = [UIImage imageNamed:@"counter.png"];
		UIImageView * counterImageView = [[UIImageView alloc] initWithImage:counterImage];
		counterImageView.contentMode = UIViewContentModeScaleAspectFit;
		counterImageView.frame = CGRectMake((x+1)*spacer, 182, counterImage.size.width, counterImage.size.height);
		[scroller insertSubview:counterImageView atIndex:0];
	}

	[scroller setContentSize:CGSizeMake(320 * [activities count], scroller.frame.size.height)];
}

- (void)clickedButton:(UIButton *)button {
	int activityIndex = button.tag;
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
	StoreItem *activity = [activities objectAtIndex:activityIndex];
	
	if ([[activity title] isEqualToString:@"Piano"]) {
		//go to music area
		MusicMenu *vc = [[[MusicMenu alloc] initWithNibName:nil bundle:nil] autorelease];
		[delegate.navCon pushViewController:vc animated:YES];		
	} else if ([[activity title] isEqualToString:@"Calendar"]) {
		//go to music area
		DayinHistory *vc = [[[DayinHistory alloc] initWithNibName:nil bundle:nil] autorelease];
		[delegate.navCon pushViewController:vc animated:YES];		
	} else {
		//apologize that there is no activity
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Sorry" 
							  message:@"This activity is not yet available." 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];		
	}

	//add activities as they become available
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
