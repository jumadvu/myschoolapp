//
//  PrincipalHelp.m
//  MySchool
//
//  Created by ashleyk on 7/5/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "PrincipalHelp.h"
#import "Library.h"


@implementation PrincipalHelp

@synthesize textLbl;
@synthesize imageView;
@synthesize helpitems;
@synthesize helpNum;

- (void)dealloc {
	[helpNum release];
	[helpitems release];
	[imageView release];
	[textLbl release];
    [super dealloc];
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self setBackgroundColor];
	[self setHelpitems:[Library getHelp]];
	[self setTopBarTitle:@"Help" withLogo:NO backButton:NO];

    [super viewDidLoad];
}

//scrolls to the correct help tidbit if the helpNum variable is set
-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	if (helpNum != nil) {
		NSLog(@"show correct help");
		NSArray *helpBit = [self.helpitems objectAtIndex:[helpNum intValue]];
		textLbl.text = (NSString*)[helpBit objectAtIndex:1];

	}
}

-(void) continueButtonClicked {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}





@end
