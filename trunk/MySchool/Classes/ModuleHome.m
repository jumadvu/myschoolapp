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
#import "ModuleCell.h"


@implementation ModuleHome

@synthesize chapterButton, tableview, moduleName, moduleNameLabel, chapters;

- (void)dealloc {
	[chapterButton release];
	[moduleName release];
	[tableview release];
    [super dealloc];
}


-(void)toChapter {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ChapterHome *vc = [[[ChapterHome alloc] initWithNibName:nil bundle:nil] autorelease];
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

<<<<<<< .mine

=======

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
>>>>>>> .r59
- (void)viewDidLoad {
    [super viewDidLoad];
<<<<<<< .mine
	moduleNameLabel.text=moduleName;
	TBXML * tbxml = [[TBXML alloc] initWithXMLFile:@"myschool" fileExtension:@"xml"];
	TBXMLElement * root = tbxml.rootXMLElement;
	chapters= [NSMutableArray new];
	TBXMLElement * module = [tbxml childElementNamed:@"module" parentElement:root];
	while (module!=nil) {
		if( [moduleName isEqualToString:[tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:module]]]){
			TBXMLElement * chapter=[tbxml childElementNamed:@"Chapter" parentElement:module];
			while (chapter!=nil){
				[chapters addObject:[tbxml textForElement:[tbxml childElementNamed:@"title" parentElement:chapter]]];
				chapter = [tbxml nextSiblingNamed:@"Chapter" searchFromElement:chapter];
			}
			break;
		}
		else{module = [tbxml nextSiblingNamed:@"module" searchFromElement:module];}
	}
	tableview.rowHeight = 60;
	tableview.backgroundColor = [UIColor clearColor];
	[tbxml release];
=======
	[self setBackgroundColor];

>>>>>>> .r59
}

<<<<<<< .mine
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [chapters count];
}
=======

>>>>>>> .r59
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
