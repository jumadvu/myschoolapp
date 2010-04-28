//
//  ColorMenu.m
//  MySchool
//
//  Created by Connor Riley on 4/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ColorMenu.h"
#import "Color.h"


@implementation ColorMenu

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
 	[self setTopBarTitle:@"Art Class" withLogo:YES backButton:YES];
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


- (void)dealloc {
    [super dealloc];
}
-(void)startLight{
	Color *vc = [[[Color alloc] initWithNibName:nil bundle:nil] autorelease];
	vc.isLight = TRUE;
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}
-(void)startPaint{
	Color *vc = [[[Color alloc] initWithNibName:nil bundle:nil] autorelease];
	vc.isLight = FALSE;
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];
}
@end
