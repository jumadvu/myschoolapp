//
//  MusicIntro.m
//  MySchool
//
//  Created by Ashley Kayler on 3/23/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "MusicIntro.h"
#import "MusicFreestyle.h"

@implementation MusicIntro

@synthesize level;
@synthesize instructions;
@synthesize heading;

- (void)dealloc {
	[heading release];
	[instructions release];
	[level release];
    [super dealloc];
}

-(void)continueOn {
	MusicFreestyle *vc = [[[MusicFreestyle alloc] initWithNibName:nil bundle:nil] autorelease];
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
	if ([level isEqualToString:@"1"]) {
		//level 1
		heading.text = @"Creating Music";
		instructions.text = @"level one instructions";
	} else {
		//level 2
		heading.text = @"Make a Song";
		instructions.text = @"level two instructions";
	}
    [super viewDidLoad];
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
