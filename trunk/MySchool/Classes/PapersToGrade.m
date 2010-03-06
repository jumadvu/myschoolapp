//
//  PapersToGrade.m
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "PapersToGrade.h"
#import "GradePaper.h"
#import "User.h"
#import "Worksheet.h"
#import "Student.h"
#import "StudentPlus.h"
#import "CompletedWorksheet.h"
#import "Lecture.h"

@implementation PapersToGrade

@synthesize students;
@synthesize myTableView;

- (void)dealloc {
	[students release];
	[myTableView release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.view.backgroundColor = [UIColor colorWithRed:.7 green:.85 blue:.85 alpha:1];	
    }
    return self;
}

/*
- (UITableView*)tableView{
    return myTableView;
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
	//self.tableView.frame = CGRectMake(0,50,320,380);
	
	/*
    myTableView = [super tableView];
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame]; 
    self.view = view;
    myTableView.frame = CGRectMake(0, 50, 320, 380);
    [view addSubview:myTableView];
	 */
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

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
	
    return [students count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];

    return [[[students objectAtIndex:section] worksheets] count];
	//return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	CompletedWorksheet *completedWorksheet = [[[students objectAtIndex:indexPath.section] completedWorksheetsArray] objectAtIndex:indexPath.row];
    // Set up the cell...
	cell.textLabel.font = [UIFont systemFontOfSize:14];
	cell.textLabel.text = [NSString stringWithFormat:@"%@", completedWorksheet.worksheet.lecture.title];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", completedWorksheet.date];
	//cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", [completedWorksheet.answers count]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	GradePaper *vc = [[[GradePaper alloc] initWithNibName:nil bundle:nil] autorelease];
	CompletedWorksheet *completedWorksheet = [[[students objectAtIndex:indexPath.section] completedWorksheetsArray] objectAtIndex:indexPath.row];
	vc.answers = [completedWorksheet.answers allObjects];
	vc.completedWorksheet = completedWorksheet;
	NSLog(@"papers to grade: how many answers: %d", [vc.answers count]);
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
	label.font = [UIFont boldSystemFontOfSize:18];
	label.frame = CGRectMake(10.0, 10.0, 280.0, 30.0);
	label.text = [[students objectAtIndex:section] firstName];
	[customView addSubview:label];
	[label release];
	return customView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 50;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/




@end

