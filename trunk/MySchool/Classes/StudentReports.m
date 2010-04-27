//
//  StudentReports.m
//  MySchool
//
//  Created by Ashley Kayler on 4/17/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "StudentReports.h"
#import "Student.h"
#import "StudentPlus.h"
#import "BehaviorReport.h"
#import "BehaviorReportPlus.h"
#import "HandleReport.h"

@implementation StudentReports

@synthesize student;
@synthesize tableView;
@synthesize frontView;
@synthesize reports;

- (void)dealloc {
	[reports release];
	[frontView release];
	[tableView release];
	[student release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	frontView.contentMode = UIViewContentModeScaleAspectFit;
	frontView.image = [student frontView];
	tableView.backgroundColor = [UIColor clearColor];
		
	self.reports = (NSMutableArray*)[[self.student reports] allObjects];
	[self setTopBarTitle:[NSString stringWithFormat:@"%@'s Behavior Reports",[self.student firstName]] withLogo:YES backButton:YES];
	
	
	
}

- (void)dismissQuestionWindow:(BOOL)correct {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSLog(@"dismissed window");
	[self dismissModalViewControllerAnimated:YES];
	
	//adjust student behavior rating
	if (correct) {
		[student adjustBehavior:@"positive"];
	} else {
		[student adjustBehavior:@"negative"];
	}
	[self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSLog(@"%d", [self.reports count]);
	return [self.reports count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		//	[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
    BehaviorReport *report = [self.reports objectAtIndex:indexPath.row];

	//create imageview
	if ([report.posNeg isEqualToString:@"positive"]) {
		cell.imageView.image = [UIImage imageNamed:@"goldstar.png"];
	} else {
		cell.imageView.image = [UIImage imageNamed:@"warningmark.png"];
	}
	
	cell.textLabel.font = [UIFont systemFontOfSize:13];
	cell.textLabel.numberOfLines = 0;
	cell.textLabel.text = [BehaviorReport replaceName:student.firstName gender:student.gender inText:report.text];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	/*
	WorksheetAnswer *answer = [self.answers objectAtIndex:indexPath.row];
	
	NSString *text = [NSString stringWithFormat:@"%d. %@", (indexPath.row+1), answer.question.text];
	CGSize constraint = CGSizeMake (300,700);
	CGSize size1 = [text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	float myHeight1 = size1.height;
	
	NSString *text2 = answer.answer;
	CGSize constraint2 = CGSizeMake (200,700);
	CGSize size2 = [text2 sizeWithFont:[UIFont fontWithName:@"Zapfino" size:14] constrainedToSize:constraint2 lineBreakMode:UILineBreakModeWordWrap];
	float myHeight2 = size2.height;
	
	float myTotalHeight = myHeight1 + myHeight2 + 20;
	*/
	return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 40;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];

	//handle behavior report
	HandleReport *vc = [[[HandleReport alloc] initWithNibName:nil bundle:nil] autorelease];
	vc.delegate = self;
	vc.report = [reports objectAtIndex:indexPath.row];
	[self presentModalViewController:vc animated:YES];

	//remove report from student and reset reports
	[student removeReportsObject:[self.reports objectAtIndex:indexPath.row]];
	self.reports = (NSMutableArray*)[[self.student reports] allObjects];
	
	//save the managed objects
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSError *error;
	if (![delegate.managedObjectContext save:&error]) {
		NSLog(@"error saving managed object");
		// Handle the error.
	}
	
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
	label.textColor = [UIColor grayColor];
	label.font = [UIFont systemFontOfSize:13];
	label.frame = CGRectMake(10.0, 10.0, 280.0, 30.0);
	if ([student.reports count] == 0) {
		label.text = @"No unread behavior reports.";
	} else {
		label.text = @"Click report to handle it.";
	}

	[customView addSubview:label];
	[label release];
	
	return customView;
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
