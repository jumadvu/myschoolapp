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
#import "Library.h"
#import "Module.h"
#import "ModulePlus.h"
#import "Article.h"
#import "Chapter.h"
#import "ClassroomHome.h"
#import "ClassroomInstructions.h"
#import "User.h"

@implementation ModuleHome

@synthesize moduleNameLabel;
@synthesize targetModule;
@synthesize tableview;
@synthesize goToLearn;

- (void)dealloc {
	[tableview release];
	[moduleNameLabel release];
	[targetModule release];
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[self setBackgroundColor];
	
	self.tableview.rowHeight = 40;
	
	moduleNameLabel.text = targetModule.title;

	[self setTopBarTitle:@"Choose a Chapter" withLogo:YES backButton:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[targetModule chaptersArray] count];
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	static NSString *CellIdentifier = @"Cell";
	ChapterCell *cell = (ChapterCell*)[aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell =
		[[[ChapterCell alloc]
		  initWithFrame:CGRectZero
		  reuseIdentifier:CellIdentifier]
		 autorelease];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		
	}
	//[cell setFileName:fileName];
	Chapter *chapter = [[self.targetModule chaptersArray] objectAtIndex:indexPath.row];
	cell.lblTitle.text = [NSString stringWithFormat:@"%d. %@", indexPath.row+1, [chapter title]];
	cell.article = chapter.article;
	cell.chapter = chapter;
	//cell.textLabel.text = [chapters objectAtIndex:[indexPath row]];
	//[chapter release];
	return cell;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//go to chapter home
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if (goToLearn) {
		//go to learning section
		ChapterHome *vc = [[[ChapterHome alloc] initWithNibName:nil bundle:nil] autorelease];
		//set up the learning page
		Chapter *chapter = [[self.targetModule chaptersArray] objectAtIndex:indexPath.row];
		[delegate setCurrentChapter:chapter];
		vc.chapter = chapter;
		[delegate.navCon pushViewController:vc animated:YES];	
	} else {
		//set the current chapter
		//go to classroom (if they have done less than 3 lessons, show them instructions first.
		Chapter *chapter = [[self.targetModule chaptersArray] objectAtIndex:indexPath.row];
		[delegate setCurrentChapter:chapter];
		if ([delegate.teacher.completedLessons count]<3) {
			ClassroomInstructions *vc = [[[ClassroomInstructions alloc] initWithNibName:nil bundle:nil] autorelease];
			[delegate.navCon pushViewController:vc animated:YES];	
		} else {
			ClassroomHome *vc = [[[ClassroomHome alloc] initWithNibName:nil bundle:nil] autorelease];
			[delegate.navCon pushViewController:vc animated:YES];	
		}		
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




@end
