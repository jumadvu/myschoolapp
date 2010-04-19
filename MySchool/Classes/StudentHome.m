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
#import "StudentPlus.h"
#import "CompletedWorksheet.h"
#import "Worksheet.h"
#import "Lecture.h"
#import "CompletedWorksheetPlus.h"
#import "StudentGrades.h"
#import "StudentReports.h"

@implementation StudentHome

@synthesize student;
@synthesize tableView;
@synthesize frontView;
@synthesize smartsBox;
@synthesize smartsScore;
@synthesize respectBox;
@synthesize respectScore;
@synthesize enthusiasmBox;
@synthesize enthusiasmScore;

- (void)dealloc {
	[smartsScore release];
	[smartsBox release];
	[respectScore release];
	[respectBox release];
	[enthusiasmBox release];
	[enthusiasmScore release];
	[frontView release];
	[tableView release];
	[student release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	//frontView.contentMode = UIViewContentModeScaleAspectFit;
	//frontView.image = [student frontView];
	tableView.backgroundColor = [UIColor clearColor];
	
	[self setTopBarTitle:[self.student firstName] withLogo:YES backButton:YES];
	
	[self.student setImageView:frontView forMood:@"Happy" isWaving:NO];
	

}

- (void)viewDidAppear:(BOOL)animated {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
    [super viewDidAppear:animated];
	//[self.tableView reloadData];
	
	//set personality scores
	self.smartsScore.text = [[self.student intelligence] stringValue];
	self.respectScore.text = [[self.student politeness] stringValue];
	self.enthusiasmScore.text = [[self.student friendliness] stringValue];
	
	//move personality score labels into position
	self.smartsScore.center = CGPointMake(115+(1.78*[[self.student intelligence] intValue]), self.smartsScore.center.y);
	self.respectScore.center = CGPointMake(115+(1.78*[[self.student politeness] intValue]), self.respectScore.center.y);
	self.enthusiasmScore.center = CGPointMake(115+(1.78*[[self.student friendliness] intValue]), self.enthusiasmScore.center.y);
	
	//move personality scores boxes into position
	self.smartsBox.center = CGPointMake(115+(1.78*[[self.student intelligence] intValue]), self.smartsBox.center.y);
	self.respectBox.center = CGPointMake(115+(1.78*[[self.student politeness] intValue]), self.respectBox.center.y);
	self.enthusiasmBox.center = CGPointMake(115+(1.78*[[self.student friendliness] intValue]), self.enthusiasmBox.center.y);

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
	
	return 2;

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
	//	[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
	cell.textLabel.font = [UIFont systemFontOfSize:13];
	cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
	if (indexPath.row == 0) {
		//grades row
		cell.textLabel.text = [NSString stringWithFormat:@"%@'s Grades", [student firstName]];
		//cell.detailTextLabel.text = [NSString stringWithFormat:@"Average: %@",[self.student overallGrade]];		
	} else {
		//behaviors row
		cell.textLabel.text = [NSString stringWithFormat:@"%@'s Behavior Reports", [student firstName]];
		//cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.student overallGrade]];		
	}

    return cell;
}


- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if (indexPath.row == 0) {
		StudentGrades *vc = [[[StudentGrades alloc] initWithNibName:nil bundle:nil] autorelease];
		vc.student = self.student;
		[delegate.navCon pushViewController:vc animated:YES];
	} else {
		StudentReports *vc = [[[StudentReports alloc] initWithNibName:nil bundle:nil] autorelease];
		vc.student = self.student;
		[delegate.navCon pushViewController:vc animated:YES];
	}

	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
	
}


@end