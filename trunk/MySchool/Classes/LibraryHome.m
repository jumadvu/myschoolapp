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
#import "Library.h"

@implementation LibraryHome

@synthesize moduleNames;
@synthesize subjects;

- (void)dealloc {
	[subjects release];
	[moduleNames release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.view.backgroundColor = [UIColor colorWithRed:.7 green:.85 blue:.85 alpha:1];	
    }
    return self;
}


- (void)viewDidLoad
{
	//
	// Change the properties of the imageView and tableView (these could be set
	// in interface builder instead).
	//
	[super viewDidLoad];
	[self setSubjects:[Library subjectsForGrade:[NSNumber numberWithInt:2]]];
	//tableView.backgroundColor = [UIColor clearColor];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    return [self.subjects count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[subjects objectAtIndex:section] objectAtIndex:0];
}
//
// tableView:numberOfRowsInSection: Returns the number of rows in a given section.
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSArray *modulesInSection = [NSArray arrayWithArray:[[subjects objectAtIndex:section] objectAtIndex:1]];
	return [modulesInSection count];
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

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *CellIdentifier = @"Cell";
	ModuleCell *cell = (ModuleCell*)[aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
	NSArray *modulesInSection = [NSArray arrayWithArray:[[subjects objectAtIndex:indexPath.section] objectAtIndex:1]];
	
	//get the filename and the title of the module for display
	[cell setFileName:[[modulesInSection objectAtIndex:[indexPath row]] objectAtIndex:1]];
	[cell setModuleName:[[modulesInSection objectAtIndex:[indexPath row]] objectAtIndex:0]];
	cell.textLabel.text = [[modulesInSection objectAtIndex:[indexPath row]] objectAtIndex:0];
	return cell;
}

/*
 //cell click handled in ModuleCell.m
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray *modulesInSection = [NSArray arrayWithArray:[[subjects objectAtIndex:indexPath.section] objectAtIndex:1]];
	NSString *fileName = [NSString stringWithFormat:[[modulesInSection objectAtIndex:[indexPath row]] objectAtIndex:1]];
    // Navigation logic may go here. Create and push another view controller.
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ModuleHome *vc = [[[ModuleHome alloc] initWithNibName:nil bundle:nil] autorelease];
	vc.moduleName = fileName;
	NSLog(@"file name %@", fileName);
	[delegate.navCon pushViewController:vc animated:YES];
}
*/
@end
