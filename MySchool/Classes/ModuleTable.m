//
//  ModuleTableController.m
//  MySchool
//
//  Created by Connor Riley on 2/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "Article.h"
#import "ModulePlus.h"
#import "Module.h"
#import "ModuleTable.h"
#import "TBXML.h"
#import "ChapterCell.h"
#import "Chapter.h"



@implementation ModuleTable

@synthesize chapters, moduleName, tableview, fileName, module;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[module chaptersArray] count];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *CellIdentifier = @"Cell";
	ChapterCell *cell = (ChapterCell*)[aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		//
		// Create the cell.
		//
		cell =
		[[[ChapterCell alloc]
		  initWithFrame:CGRectZero
		  reuseIdentifier:CellIdentifier]
		 autorelease];
		
	}
	[cell setFileName:fileName];
	Chapter *chapter = [[module chaptersArray] objectAtIndex:indexPath.row];
	cell.lblTitle.text = [chapter title];
	cell.article = chapter.article;
	cell.chapter = chapter;
	//cell.textLabel.text = [chapters objectAtIndex:[indexPath row]];
	[chapter release];
	return cell;
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


- (void)dealloc {
	[chapters release];
	[moduleName release];
    [tableview release];
	[fileName release];
	[module release];
	[super dealloc];
}


@end
