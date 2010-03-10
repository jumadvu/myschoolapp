//
//  GradePaper.m
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "GradePaper.h"
#import "WorksheetAnswer.h"
#import "WorksheetQuestion.h"
#import "CompletedWorksheet.h"
#import "Worksheet.h"
#import "Lecture.h"
#import "GradePaperCell.h"
#import "Student.h"
#import "User.h"
#import "UserPlus.h"

@implementation GradePaper

@synthesize answers;
@synthesize completedWorksheet;
@synthesize completedWorksheets;
@synthesize answersGradedArray;
@synthesize gradeLabel;
@synthesize currentPaper;

- (void)dealloc {
	[gradeLabel release];
	[answersGradedArray release];
	[completedWorksheet release];
	[completedWorksheets release];
	[answers release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:UITableViewStylePlain]) {
		self.view.backgroundColor = [UIColor whiteColor];	
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self setCompletedWorksheets:[delegate.teacher ungradedPapers]];
	
	[self setCompletedWorksheet:[completedWorksheets objectAtIndex:0]];
	[self setAnswers:[[completedWorksheet answers] allObjects]];
	NSMutableArray *anArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], nil];
	[self setAnswersGradedArray:anArray];
	self.tableView.allowsSelection = NO;
	currentPaper = 0;
}

- (void)viewDidAppear:(BOOL)animated {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
    [super viewDidAppear:animated];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(void)gradedQuestion:(NSNumber*)row value:(NSNumber*)value{
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	NSLog(@"%d", [row intValue]);
	[self.answersGradedArray replaceObjectAtIndex:[row intValue] withObject:value];
	BOOL completed = YES;
	int score = 0;
	for (int x=0; x<[self.answersGradedArray count]; x++) {
		if ([[self.answersGradedArray objectAtIndex:x] intValue] == 2) {
			NSLog(@"not yet graded");
			completed = NO;
		} else {
			NSLog(@"graded");
			score += [[self.answersGradedArray objectAtIndex:x] intValue];
		}
	}
	if (completed) {
		self.completedWorksheet.grade = [NSNumber numberWithInt:score];
		NSError *error;
		if (![delegate.managedObjectContext save:&error]) {
			NSLog(@"error saving managed object");
			// Handle the error.
		}
		switch (score) {
			case 0:
				gradeLabel.text = @"D";
				break;
			case 1:
				gradeLabel.text = @"B-";
				break;
			case 2:
				gradeLabel.text = @"A-";
				break;
			case 3:
				gradeLabel.text = @"A+";
				break;
			default:
				break;
		}
		
	}
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
    //return [answers count];
	return 3;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
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

	CGRect cellFrame = CGRectMake(0,0,myTotalHeight,320);

    GradePaperCell *cell = (GradePaperCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[GradePaperCell alloc] initWithFrame:cellFrame reuseIdentifier:CellIdentifier] autorelease];
		cell.delegate = self;
		cell.wrongButton.tag = indexPath.row;
		cell.correctButton.tag = indexPath.row;
		cell.wrongButton.alpha = 1;
		cell.correctButton.alpha = 1;
    }
    
	[cell setQuestion:text andAnswer:text2 qHeight:[NSNumber numberWithFloat:myHeight1] aHeight:[NSNumber numberWithFloat:myHeight2]];
    
	return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
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
	
	return myTotalHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	
	[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	//[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	
	NSString *formattedDateString = [dateFormatter stringFromDate:completedWorksheet.date];
	[dateFormatter release];

	
	// create the parent view that will hold header Label
	UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 50.0)] autorelease];
	customView.backgroundColor = [UIColor clearColor];
	
	// create the heading label object
	UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:15];
	label.textAlignment = UITextAlignmentCenter;
	label.frame = CGRectMake(10.0, 45.0, 300.0, 30.0);
	WorksheetAnswer *wAnswer = [answers objectAtIndex:section];
	label.text = wAnswer.question.worksheet.lecture.title;
	[customView addSubview:label];
	[label release];
	
	// create the heading label object
	self.gradeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.gradeLabel.backgroundColor = [UIColor clearColor];
	self.gradeLabel.font = [UIFont boldSystemFontOfSize:30];
	self.gradeLabel.textAlignment = UITextAlignmentCenter;
	self.gradeLabel.frame = CGRectMake(130.0, 10.0, 60.0, 45.0);
	self.gradeLabel.text = @"";
	[customView addSubview:self.gradeLabel];
	[self.gradeLabel release];
	
	// create the heading label object
	UILabel * datelabel = [[UILabel alloc] initWithFrame:CGRectZero];
	datelabel.backgroundColor = [UIColor clearColor];
	datelabel.font = [UIFont systemFontOfSize:12];
	datelabel.frame = CGRectMake(200.0, 10.0, 40.0, 30.0);
	datelabel.text = [NSString stringWithFormat:@"Date:"];
	[customView addSubview:datelabel];
	[datelabel release];

	// create the heading label object
	UILabel * studentDatelabel = [[UILabel alloc] initWithFrame:CGRectZero];
	studentDatelabel.backgroundColor = [UIColor clearColor];
	studentDatelabel.font = [UIFont fontWithName:@"Zapfino" size:12];
	studentDatelabel.frame = CGRectMake(240.0, 10.0, 80.0, 30.0);
	studentDatelabel.text = formattedDateString;
	[customView addSubview:studentDatelabel];
	[studentDatelabel release];
	
	// create the heading label object
	UILabel * namelabel = [[UILabel alloc] initWithFrame:CGRectZero];
	namelabel.backgroundColor = [UIColor clearColor];
	namelabel.font = [UIFont systemFontOfSize:12];
	namelabel.frame = CGRectMake(5.0, 10.0, 40.0, 30.0);
	namelabel.text = [NSString stringWithFormat:@"Name: "];
	[customView addSubview:namelabel];
	[namelabel release];

	// create the heading label object
	UILabel * studentNamelabel = [[UILabel alloc] initWithFrame:CGRectZero];
	studentNamelabel.backgroundColor = [UIColor clearColor];
	studentNamelabel.font = [UIFont fontWithName:@"Zapfino" size:15];
	studentNamelabel.frame = CGRectMake(45.0, 10.0, 180.0, 30.0);
	studentNamelabel.text = completedWorksheet.student.firstName;	
	[customView addSubview:studentNamelabel];
	[studentNamelabel release];
	
	
	return customView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	// create the parent view that will hold header Label
	UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 100.0)] autorelease];
	customView.backgroundColor = [UIColor clearColor];
	

	UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
	backButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
	[backButton setTitle:@"Back" forState:UIControlStateNormal];
	backButton.frame = CGRectMake(20, 10, 70.0, 30.0);  
	[backButton addTarget:self action:@selector(goBackwards:) forControlEvents:UIControlEventTouchUpInside];  
	[customView addSubview:backButton];
	 
	
	UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
	nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
	[nextButton setTitle:@"Next Paper" forState:UIControlStateNormal];
	nextButton.frame = CGRectMake(200, 10, 100.0, 30.0);  
	[nextButton addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];  
	[customView addSubview:nextButton];
		
	return customView;
}

-(void)goBackwards:(id)sender {
	NSLog(@"going back");
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon popViewControllerAnimated:YES];		
	
}

-(void)goNext {
	NSLog(@"go next");
	currentPaper++;
	if (currentPaper < [completedWorksheets count]) {
		[self setCompletedWorksheet:[completedWorksheets objectAtIndex:currentPaper]];
		[self setAnswers:[[completedWorksheet answers] allObjects]];
		NSMutableArray *anArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], nil];
		[self setAnswersGradedArray:anArray];
		[self.tableView reloadData];
	} else {
		//message that all worksheets are graded
		NSString *msg = [NSString stringWithFormat:@"You have graded all your papers! Your students will be excited to get their grades."];
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Way to go!" 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		[delegate.navCon popViewControllerAnimated:YES];		

	}

	
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 85;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 85;
}


@end