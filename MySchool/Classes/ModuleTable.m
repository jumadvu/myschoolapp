//
//  ModuleTableController.m
//  MySchool
//
//  Created by Connor Riley on 2/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModuleTable.h"
#import "TBXML.h"
#import "ChapterCell.h"


@implementation ModuleTable

@synthesize chapters, moduleName, tableview, fileName;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad {
	TBXML * tbxml = [[TBXML alloc] initWithXMLFile:fileName fileExtension:@"xml"];
	TBXMLElement * root = tbxml.rootXMLElement;
	chapters= [NSMutableArray new];
	TBXMLElement * module = [tbxml childElementNamed:@"module" parentElement:root];
	while (module!=nil) {
		if( [moduleName isEqualToString:[tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:module]]]){
			TBXMLElement * chapter=[tbxml childElementNamed:@"chapter" parentElement:module];
			while (chapter!=nil){
				[chapters addObject:[tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:chapter]]];
				chapter = [tbxml nextSiblingNamed:@"chapter" searchFromElement:chapter];
			}
			break;
		}
		else{module = [tbxml nextSiblingNamed:@"module" searchFromElement:module];}
	}

	[tbxml release];
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
	return [chapters count];
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
	cell.textLabel.text = [chapters objectAtIndex:[indexPath row]];
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
	[super dealloc];
}


@end
