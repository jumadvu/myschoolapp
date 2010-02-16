//
//  ModuleHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "ModuleHome.h"
#import "ChapterHome.h"
#import "TBXML.h"
#import "ChapterCell.h"


@implementation ModuleHome

@synthesize chapterButton, tableview, moduleNameLabel, chapters, moduleName, fileName;

- (void)dealloc {
	[fileName release];
	[chapterButton release];
	[tableview release];
	[moduleName release];
    [super dealloc];
}


-(void)toChapter {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ChapterHome *vc = [[[ChapterHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[delegate.navCon pushViewController:vc animated:YES];	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setBackgroundColor];
	NSLog(@"file name %@", fileName);
	moduleNameLabel.text=moduleName;
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
	tableview.rowHeight = 60;
	tableview.backgroundColor = [UIColor clearColor];
	[tbxml release];
}
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




@end
