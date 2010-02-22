//
//  LessonsTaught.m
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "LessonsTaught.h"
#import "Module.h"
#import "Chapter.h"
#import "ModulePlus.h"
#import "Library.h"
#import "StudentHome.h"
#import "ClassroomHome.h"
#import "User.h"
#import "ChapterPlus.h"

@implementation LessonsTaught

@synthesize modules;
@synthesize tableView;

- (void)dealloc {
	[tableView release];
	[modules release];
    [super dealloc];
}

-(void)goBack {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon setNavigationBarHidden:YES];

	[delegate.navCon popViewControllerAnimated:YES];		
	
}

- (void)viewDidLoad {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
	[self setBackgroundColor];
	//[delegate.navCon setNavigationBarHidden:NO];
	//self.navigationItem.rightBarButtonItem = self.editButtonItem;

	[tableView setBackgroundColor:[UIColor clearColor]];
	
	modules = [Library fetchModulesFromDBforGrade:[NSNumber numberWithInt:2]];
	//if there are no modules in the library, add the dinosaur module
	if ([modules count] == 0) {
		[Library addXMLModule:@"dinosaurs" toDatabaseContext:delegate.managedObjectContext];
		modules = [Library fetchModulesFromDBforGrade:[NSNumber numberWithInt:2]];		
	}
	 
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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
	NSLog(@"Number modules: %d",[modules count]);
    return [modules count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [[[modules objectAtIndex:section] chaptersArray] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	Chapter *chapter = [[[modules objectAtIndex:indexPath.section] chaptersArray] objectAtIndex:indexPath.row];
	cell.textLabel.text = [chapter title];
	cell.detailTextLabel.text = [chapter maxPointsForUsersCompletedLessonsAsString:[delegate.teacher.completedLessons allObjects]];
    //cell.detailTextLabel.text = @"10pts";
	if (cell.detailTextLabel.text == nil) {
		cell.textLabel.font = [UIFont systemFontOfSize:12.0];
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.textLabel.textColor = [UIColor grayColor];
	}
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForHeaderInSection:(NSInteger)section
{
	return 45;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	Chapter *chapter = [[[modules objectAtIndex:indexPath.section] chaptersArray] objectAtIndex:indexPath.row];
	NSString *aString = [chapter maxPointsForUsersCompletedLessonsAsString:[delegate.teacher.completedLessons allObjects]];
	
    if (aString == nil) {
		return 22;
	} else {
		return 35;
	}
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon setNavigationBarHidden:YES];
	ClassroomHome *vc = [[[ClassroomHome alloc] initWithNibName:nil bundle:nil] autorelease];
	//vc.student = [students objectAtIndex:indexPath.row];
	[delegate setCurrentChapter:[[[modules objectAtIndex:indexPath.section] chaptersArray] objectAtIndex:indexPath.row]];
	[delegate.navCon pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)aTableView viewForHeaderInSection:(NSInteger)section
{
	UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 50.0)] autorelease];
	customView.backgroundColor = [UIColor clearColor];

	// create the heading label object
	UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = UITextAlignmentLeft;
	label.font = [UIFont boldSystemFontOfSize:17];
	label.frame = CGRectMake(10.0, 10.0, 300.0, 30.0);
	label.text = [NSString stringWithFormat:@"Module: %@",[[modules objectAtIndex:section] title]];
	[customView addSubview:label];
	[label release];

	return customView;

}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)aTableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}




@end

