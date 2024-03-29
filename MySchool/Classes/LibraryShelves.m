//
//  LibraryShelves.m
//  MySchool
//
//  Created by Ashley Kayler on 2/24/10.
//  Copyright 2010 DataJedi. All rights reserved.
//
#import "MySchoolAppDelegate.h"
#import "LibraryShelves.h"
#import "Module.h"
#import "Library.h"
#import "Chapter.h"
#import "ModuleHome.h"
#import "ModulePlus.h"
#import "ColorMenu.h"
#import "User.h"


@implementation LibraryShelves

@synthesize scrollView;
@synthesize segmentControl;
@synthesize subjects;
@synthesize bookImages;
@synthesize shelfMarkers;
@synthesize subjectNames;

- (void)dealloc {
	[subjectNames release];
	[shelfMarkers release];
	[bookImages release];
	[subjects release];
	[scrollView release];
	[segmentControl release];
    [super dealloc];
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
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor colorWithRed:.5 green:.2 blue:.1 alpha:1]];
	[self setTopBarTitle:@"The Library" withLogo:YES backButton:YES];
	
	NSMutableArray *anArray = [[NSMutableArray alloc] init];
	self.shelfMarkers = anArray;
	[anArray release];
	
	bookImages  = [[NSArray alloc] initWithObjects:
				   [UIImage imageNamed:@"bookw1.png"],
				   [UIImage imageNamed:@"bookw2.png"],
				   [UIImage imageNamed:@"bookw3.png"],
				   [UIImage imageNamed:@"bookw4.png"],
				   [UIImage imageNamed:@"bookw5.png"],
				   [UIImage imageNamed:@"bookw6.png"],
							 nil];
	
	[self setSubjects:[Library subjectsForGrade:[NSNumber numberWithInt:2]]];

	NSMutableArray *segmentTextContent = [[NSMutableArray alloc] init];
	self.subjectNames = segmentTextContent;
	[segmentTextContent release];

	[self loadBooksIntoScrollView];

	/*
	UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:subjectNames];
	segmentControl = segControl;
	
	[segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	segmentControl.segmentedControlStyle = UISegmentedControlStyleBar;	
	segmentControl.tintColor = [UIColor colorWithRed:0.70 green:0.171 blue:0.1 alpha:1.0];
	*/
}

-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	NSLog(@"view did appear in library shelves");
}

- (void)segmentAction:(id)sender
{
	NSLog(@"segmentAction: selected segment = %d", [sender selectedSegmentIndex]);
	NSLog(@"marker %d", [[shelfMarkers objectAtIndex:[sender selectedSegmentIndex]] intValue]);
	
	[scrollView setContentOffset:CGPointMake([[shelfMarkers objectAtIndex:[sender selectedSegmentIndex]] intValue], 0) animated:YES];
}

-(void)loadBooksIntoScrollView {
	//create a UILabel for each regular word in the text and a UIButton for each keyword
	//add these labels and buttons to the scrollview
	
	scrollView.backgroundColor = [UIColor clearColor];
	int x = 0;
	int y = 0;
	int ytop = 20;
	int ybottom = 180;
	int spacer = 5;
	int tagCount = 0;
	
	NSArray *modulesInSubject;
	
	for (int i = 0; i< [subjects count]; i++) {
		modulesInSubject = [NSArray arrayWithArray:[[subjects objectAtIndex:i] objectAtIndex:1]];
		NSArray *module;
		[shelfMarkers addObject:[NSNumber numberWithInt:x-10]];
		[subjectNames addObject:[[subjects objectAtIndex:i] objectAtIndex:0]];
		y = ytop;
		for (module in modulesInSubject) {
			//shelf marker marks the x value for the content offset for segment controller
			UIButton *bookButton = [UIButton buttonWithType:UIButtonTypeCustom]; 
			bookButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];

			//set book background
			NSString *title = [module objectAtIndex:0];
			//NSLog(@"%@", title);
			int randomNum = [title length] % 6;
			//this probably shouldn't be random. Book should retain its look
			UIImage *bimage = [bookImages objectAtIndex:randomNum];
			[bookButton setBackgroundImage:bimage forState:UIControlStateNormal];
			[bookButton setTitle:[module objectAtIndex:0] forState:UIControlStateNormal];
			bookButton.contentMode = UIViewContentModeScaleAspectFit;
			bookButton.titleLabel.lineBreakMode= UILineBreakModeWordWrap;
			bookButton.titleEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
			[bookButton.titleLabel setTextAlignment:UITextAlignmentCenter];
			
			bookButton.tag = tagCount;
			[bookButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];  
			bookButton.frame = CGRectMake(x, y, bimage.size.width, bimage.size.height);  
			
			//CGRect newFrame = CGRectMake(x, (320 - (bookButton.frame.size.height+100)), bookButton.frame.size.width, bookButton.frame.size.height+100);
			//bookButton.frame = newFrame;
			
			[scrollView addSubview:bookButton];
			tagCount++;
			if(y == ytop){
				y = ybottom;
			}else{
				x += bookButton.frame.size.width + spacer;
				y = ytop;
			}

		}
		
		x += 40; //add space between subjects
		if (y == ybottom) {
			x += 170; //add some additional space if there was an odd number of books in previous subject
		}
	}
	[scrollView setContentSize:CGSizeMake(x, 320)];
	
}

- (void)clickedButton:(UIButton *)button {
	//int keywordIndex = button.tag;
	//get the module from the sqllite db and pass it to the next view

	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if ([button.titleLabel.text isEqualToString:@"Today in History"]) {
		//go to music area
		ColorMenu *vc = [[[ColorMenu alloc] initWithNibName:nil bundle:nil] autorelease];
		[delegate.navCon pushViewController:vc animated:YES];		
	} else {
		@try {
			ModuleHome *vc = [[[ModuleHome alloc] initWithNibName:nil bundle:nil] autorelease];
			Module *selectedModule = [Module getModuleWithName:button.titleLabel.text];
			vc.targetModule= selectedModule;
			vc.goToLearn = YES;
			//save the current module that the user is working on.
			[delegate.teacher setCurrentModule:selectedModule];
			[delegate.navCon pushViewController:vc animated:YES];
		}
		@catch (NSException* ex) {
			UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Uh-oh!" message:@"This book isn't available yet! Try another one." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
			[alert show];
		}
	}
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
