//
//  StudentsList.m
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "StudentsList.h"
#import "StudentHome.h"
#import "User.h"
#import "Student.h"
#import "StudentPlus.h"

@implementation StudentsList

@synthesize students;

- (void)dealloc {
	[students release];
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
	self.tableView.rowHeight = 80;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)toMainMenu {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon popToRootViewControllerAnimated:YES];		
}

- (void)viewDidAppear:(BOOL)animated {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
    [super viewDidAppear:animated];
	[self setStudents:[delegate.teacher.students allObjects]];
	[self.tableView reloadData];
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
	
    return [students count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
	
	UIImage *image = [UIImage imageNamed:@"gradient_button.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	imageView.contentMode = UIViewContentModeScaleToFill;
	cell.backgroundView = imageView;
	[imageView release];
	
    // Set up the cell...
	cell.imageView.image = [[students objectAtIndex:indexPath.row] frontView];
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.textLabel.text = [NSString stringWithFormat:@"%@", [[students objectAtIndex:indexPath.row] firstName]];
	//cell.detailTextLabel.text = [NSString stringWithFormat:@"B+"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	StudentHome *vc = [[[StudentHome alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
	vc.student = [students objectAtIndex:indexPath.row];
	[delegate.navCon pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	// create the parent view that will hold header Label
	UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 50.0)] autorelease];
	customView.backgroundColor = [UIColor clearColor];
	
	// create the heading label object
	UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
	label.backgroundColor = [UIColor clearColor];
	//teamAveLabel.opaque = NO;
	label.textAlignment = UITextAlignmentCenter;
	label.font = [UIFont boldSystemFontOfSize:24];
	label.frame = CGRectMake(10.0, 10.0, 300.0, 30.0);
	label.text = @"Student Gradebook";
	[customView addSubview:label];
	
	
	[customView addSubview:label];
	[label release];
	return customView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	// create the parent view that will hold header Label
	UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 100.0)] autorelease];
	customView.backgroundColor = [UIColor clearColor];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
	button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
	[button setTitle:@"Main Menu" forState:UIControlStateNormal];
	button.frame = CGRectMake(110, 10, 100.0, 30.0);  
	[button addTarget:self action:@selector(toMainMenu) forControlEvents:UIControlEventTouchUpInside];  
	[customView addSubview:button];
	//[button release];
	return customView;
}


@end
