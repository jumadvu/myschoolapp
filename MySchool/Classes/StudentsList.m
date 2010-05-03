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
@synthesize tableview;

- (void)dealloc {
	[tableview release];
	[students release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableview.rowHeight = 105;
	self.tableview.backgroundColor = [UIColor clearColor];
	[self setBackgroundColor];

	[self setTopBarTitle:@"My Students" withLogo:YES backButton:YES];
}

- (void)viewDidAppear:(BOOL)animated {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
    [super viewDidAppear:animated];
	[self setStudents:[delegate.teacher.students allObjects]];
	[self.tableview reloadData];
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
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
	
    // Set up the cell...
	
	UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(170, 0, 100, 100)];
	aView.clipsToBounds = YES;
					 
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[(Student*)[students objectAtIndex:indexPath.row] frontView]];
	imageView.frame = CGRectMake(0, -30, 100, 200);
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	//imageView.transform = CGAffineTransformMakeScale(.5,.5);
	//imageView.frame = CGRectMake(0.0, 0.0, 193*scale, 346*scale);
	[aView addSubview:imageView];
	[cell addSubview:aView];
	[aView release];
	[imageView release];
	
	//[cell.imageView setImage:[(Student*)[students objectAtIndex:indexPath.row] frontView]];

	//[(Student*)[students objectAtIndex:indexPath.row] setImageView:cell.imageView forMood:@"Happy" isWaving:NO];

	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.textLabel.text = [NSString stringWithFormat:@"%@", [[students objectAtIndex:indexPath.row] firstName]];
	//cell.detailTextLabel.text = [NSString stringWithFormat:@"B+"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	StudentHome *vc = [[[StudentHome alloc] initWithNibName:nil bundle:nil] autorelease];
	vc.student = [students objectAtIndex:indexPath.row];
	[delegate.navCon pushViewController:vc animated:YES];
}

@end
