//
//  StudentGrades.m
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "StudentGrades.h"
#import "User.h"
#import "Student.h"
#import "StudentPlus.h"
#import "CompletedWorksheet.h"
#import "Worksheet.h"
#import "Lecture.h"
#import "CompletedWorksheetPlus.h"

@implementation StudentGrades

@synthesize student;
@synthesize tableView;
@synthesize heading;
@synthesize gradeLabel;
@synthesize frontView;

- (void)dealloc {
	[gradeLabel release];
	[frontView release];
	[heading release];
	[tableView release];
	[student release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	frontView.contentMode = UIViewContentModeScaleAspectFit;
	frontView.image = [student frontView];
	tableView.backgroundColor = [UIColor clearColor];
	heading.text = [self.student firstName];
	gradeLabel.text = [NSString stringWithFormat:@"Overall Grade: %@",[self.student overallGrade]];
	
	[self setTopBarTitle:[NSString stringWithFormat:@"%@'s Grades",[self.student firstName]] withLogo:YES backButton:YES];
	[self setBackgroundColor];

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
	if ([[student.worksheets allObjects] count] > 0) {
		return [[student completedWorksheetsArray] count];
	} else {
		return 0;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		//	[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
    CompletedWorksheet *cWorksheet = [[student completedWorksheetsArray] objectAtIndex:indexPath.row];
    // Set up the cell...
	cell.textLabel.font = [UIFont systemFontOfSize:13];
	cell.textLabel.text = [NSString stringWithFormat:cWorksheet.worksheet.lecture.title];
	cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
	cell.detailTextLabel.text = [cWorksheet letterGrade];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//do we want to show the completed worksheet?
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	// create the parent view that will hold header Label
	UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40)] autorelease];
	customView.backgroundColor = [UIColor clearColor];
	
	// create the heading label object
	UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = UITextAlignmentCenter;
	label.font = [UIFont systemFontOfSize:15];
	label.frame = CGRectMake(10.0, 10.0, 280.0, 30.0);
	if ([[student completedWorksheetsArray] count] == 0) {
		label.text = @"No worksheets completed.";
	} else {
		label.text = @"Worksheets";
	}
	[customView addSubview:label];
	[label release];
	
	return customView;
}


@end