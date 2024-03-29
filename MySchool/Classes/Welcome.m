//
//  Welcome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "Welcome.h"
#import "MySchoolAppDelegate.h"
#import "NewGameHome.h"

@implementation Welcome

- (void)dealloc {
    [super dealloc];
}

-(void)gotoFirstPage {
	//go to login page
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NewGameHome *vc = [[[NewGameHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[delegate.navCon pushViewController:vc animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self setBackgroundColor];
    [super viewDidLoad];
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
