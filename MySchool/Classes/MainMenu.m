//
//  MainMenu.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "MainMenu.h"
#import "GameStatusHome.h"

@implementation MainMenu

@synthesize statusNavController;
@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;

- (void)dealloc {
	[statusNavController release];
	[button1 release];
	[button2 release];
	[button3 release];
	[button4 release];
    [super dealloc];
}

-(void)clickButton1 {
	GameStatusHome *vc = [[[GameStatusHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[self.view addSubview:vc.view];
}

-(void)clickButton2 {
	GameStatusHome *vc = [[[GameStatusHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[self.view addSubview:vc.view];
}

-(void)clickButton3 {
	GameStatusHome *vc = [[[GameStatusHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[self.view addSubview:vc.view];
}

-(void)clickButton4 {
	GameStatusHome *vc = [[[GameStatusHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[self.view addSubview:vc.view];
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
	[self.view addSubview:statusNavController.view];
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
