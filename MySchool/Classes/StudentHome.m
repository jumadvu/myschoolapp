//
//  StudentHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "StudentHome.h"
#import "User.h"
#import "Student.h"


@implementation StudentHome

@synthesize student;

- (void)dealloc {
	[student release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.view.backgroundColor = [UIColor colorWithRed:.7 green:.85 blue:.85 alpha:1];	
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)toMainMenu {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon popToRootViewControllerAnimated:YES];		
}


- (void)viewDidAppear:(BOOL)animated {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
    [super viewDidAppear:animated];
	//[self.tableView reloadData];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	//student worksheets
    return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
	//	[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
    
    // Set up the cell...
	cell.textLabel.text = [NSString stringWithFormat:@"Worksheet %d", indexPath.row];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"B+"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//do we want to show the completed worksheet?
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	// create the parent view that will hold header Label
	UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 100.0)] autorelease];
	customView.backgroundColor = [UIColor clearColor];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
	button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
	[button setTitle:@"Main Menu" forState:UIControlStateNormal];
	button.frame = CGRectMake(110, 10, 100.0, 30.0);  
	[button addTarget:self action:@selector(toMainMenu) forControlEvents:UIControlEventTouchUpInside];  
	
	// create the heading label object
	UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = UITextAlignmentCenter;
	label.font = [UIFont boldSystemFontOfSize:22];
	label.frame = CGRectMake(10.0, 60.0, 280.0, 30.0);
	label.text = [NSString stringWithFormat:@"%@'s Worksheets", [self.student firstName]];
	[customView addSubview:label];
	
	[customView addSubview:button];
	[label release];
	return customView;
}


@end