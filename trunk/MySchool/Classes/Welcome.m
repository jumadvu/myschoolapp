//
//  Welcome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "Welcome.h"
#import "MySchoolAppDelegate.h"


@implementation Welcome

@synthesize backButton;

- (void)dealloc {
    [super dealloc];
}

-(void)gotoFirstPage {
	//test
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
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
