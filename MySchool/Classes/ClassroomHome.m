//
//  ClassroomHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "ClassroomHome.h"
#import "ChalkboardHome.h"
#import "StudentQuestionHome.h"
#import "PassOutWorksheets.h"
#import "Library.h"
#import "Chapter.h"

@implementation ClassroomHome

@synthesize chalkboardButton;
@synthesize questionButton;
@synthesize worksheetsButton;
@synthesize chapter;


- (void)dealloc {
	[worksheetsButton release];
	[questionButton release];
	[chalkboardButton release];
    [super dealloc];
}

-(void)toChalkboard {
	//go back to previous page
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ChalkboardHome *vc = [[[ChalkboardHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[delegate.navCon pushViewController:vc animated:YES];
	
}
-(void)toQuestion {
	//go back to previous page
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	StudentQuestionHome *vc = [[[StudentQuestionHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[delegate.navCon pushViewController:vc animated:YES];
	
}
-(void)toWorksheets {
	//go back to previous page
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	PassOutWorksheets *vc = [[[PassOutWorksheets alloc] initWithNibName:nil bundle:nil] autorelease];
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
    [super viewDidLoad];
	[self setBackgroundColor];
	//add the lecture to teach to the database
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	//add modules to sqlite db
	//[Library addXMLModule:@"dinosaurs" toDatabaseContext:delegate.managedObjectContext];
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
