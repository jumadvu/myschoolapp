//
//  LoginController.m
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright DataJedi 2010. All rights reserved.
//

#import "LoginController.h"
#import "Welcome.h"
#import "MySchoolAppDelegate.h"
#import "MainMenu.h"

@implementation LoginController

@synthesize goNextButton;
@synthesize imageButton;

- (void)dealloc {
	[imageButton release];
	[goNextButton release];
    [super dealloc];
}

-(void)gotoNextPage {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSLog(@"go to next page");
	[delegate.navCon popViewControllerAnimated:YES];
	
}

-(void)toMainMenu {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSLog(@"go to next page");
	MainMenu *vc = [[[MainMenu alloc] initWithNibName:nil bundle:nil] autorelease];
	[delegate.navCon pushViewController:vc animated:YES];
	
}

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		NSLog(@"init Login");
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
