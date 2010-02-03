//
//  LibraryHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "LibraryHome.h"
#import "ModuleHome.h"
#import "TBXML.h"
#import "ModuleCell.h"

@implementation LibraryHome

@synthesize moduleButton, tableView, moduleNames;

- (void)dealloc {
	[moduleButton release];
	[tableView release];
	[moduleNames release];
    [super dealloc];
}

-(void)toModule {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ModuleHome *vc = [[[ModuleHome alloc] initWithNibName:nil bundle:nil] autorelease];
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

- (void)viewDidLoad
{
	//
	// Change the properties of the imageView and tableView (these could be set
	// in interface builder instead).
	//
	[super viewDidLoad];
	tableView.rowHeight = 60;
	tableView.backgroundColor = [UIColor clearColor];
    
}

//
// tableView:numberOfRowsInSection:
//
// Returns the number of rows in a given section.
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	TBXML * tbxml = [[TBXML alloc] initWithXMLFile:@"myschool" fileExtension:@"xml"];
	TBXMLElement * root = tbxml.rootXMLElement;
	moduleNames= [NSMutableArray new];
	TBXMLElement * module = [tbxml childElementNamed:@"module" parentElement:root];
	while (module!=nil) {
		NSString * mName = [tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:module]];
		[moduleNames addObject:mName];
		module = [tbxml nextSiblingNamed:@"module" searchFromElement:module];
	}
	[tbxml release];
	return [moduleNames count];
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

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *CellIdentifier = @"Cell";
	ModuleCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		//
		// Create the cell.
		//
		cell =
		[[[ModuleCell alloc]
		  initWithFrame:CGRectZero
		  reuseIdentifier:CellIdentifier]
		 autorelease];
		
	}
	cell.textLabel.text = [moduleNames objectAtIndex:[indexPath row]];
	return cell;
}



@end
