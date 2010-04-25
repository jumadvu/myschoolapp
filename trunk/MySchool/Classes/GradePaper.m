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
#import "CompletedWorksheetPlus.h"
#import "ScoreAnim.h"

@implementation GradePaper

@synthesize answers;
@synthesize completedWorksheet;
@synthesize completedWorksheets;
@synthesize answersGradedArray;
@synthesize gradeLabel;
@synthesize currentPaper; //int
@synthesize tableview;
@synthesize allDone;

- (void)dealloc {
	NSLog(@"grade paper dealloc");
	[tableview release];
	[gradeLabel release];
	[answersGradedArray release];
	[answers release];
	[completedWorksheet release];
	[completedWorksheets release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"grade paper view did load");
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[self setTopBarTitle:@"Grade Homework" withLogo:YES backButton:YES];

	//get all the completed worksheets
	[self setCompletedWorksheets:[delegate.teacher ungradedPapers]];

	//set up first worksheet
	[self setCompletedWorksheet:[completedWorksheets objectAtIndex:0]];

	//grab the students answers
	[self setAnswers:[[self.completedWorksheet answers] allObjects]];

	//create an array to hold the yes/no answer for each question
	NSMutableArray *anArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], nil];
	[self setAnswersGradedArray:anArray];
	
	//prevent selection of table view cells
	self.tableview.allowsSelection = NO;
	self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	currentPaper = 0;
}

- (void)viewDidAppear:(BOOL)animated {
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
    [super viewDidAppear:animated];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.answersGradedArray = nil;
	self.answers = nil;
	self.completedWorksheet = nil;
	self.completedWorksheets = nil;
	
}

-(void)gradedQuestion:(NSNumber*)row value:(NSNumber*)value{
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		
	WorksheetAnswer *answer = [self.answers objectAtIndex:[row intValue]];

	NSLog(@"Correctness value: %d", [answer.correctness intValue]);

	NSNumber *gotItRight;
	if ([value intValue] == 0) {
		//marked it wrong
		if ([answer.correctness intValue] > 0) {
			//oops it was a good answer
			gotItRight = [NSNumber numberWithInt:0];
		} else {
			//thats right, it was the wrong answer
			gotItRight = [NSNumber numberWithInt:1];
		}
	} else {
		//marked it right
		if ([answer.correctness intValue] > 0) {
			//that's right it was a right answer
			gotItRight = [NSNumber numberWithInt:1];
		} else {
			//oops, it was a wrong answer
			gotItRight = [NSNumber numberWithInt:0];
		}

	}

	//flash the principal head image
	ScoreAnim *anim = [[ScoreAnim alloc] showApproval:gotItRight];
	[self.view addSubview:anim];
	[anim release];
	
	//adjust this user's "principal's approval rating"
	[delegate.teacher adjustApprovalRating:gotItRight];
	

	//check to see if all the questions have been graded	
	[self.answersGradedArray replaceObjectAtIndex:[row intValue] withObject:value];
	self.allDone = YES;
	int score = 0;
	for (int x=0; x<[self.answersGradedArray count]; x++) {
		if ([[self.answersGradedArray objectAtIndex:x] intValue] == 2) {
			NSLog(@"not yet graded");
			self.allDone = NO;
		} else {
			NSLog(@"graded");
			score += [[self.answersGradedArray objectAtIndex:x] intValue];
		}
	}
	
	//if all questions are graded, then show a dialog box and move on
	if (self.allDone) {
		self.completedWorksheet.grade = [NSNumber numberWithInt:score];
		NSError *error;
		if (![delegate.managedObjectContext save:&error]) {
			NSLog(@"error saving managed object");
			// Handle the error.
		}
		[self.gradeLabel setText:[self.completedWorksheet letterGrade]];

		//go to the next paper
		[self goNext];
		
		
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
    
	NSLog(@"cell for row at index path:%d", indexPath.row);
    static NSString *CellIdentifier = @"Cell";
    
	WorksheetAnswer *answer = [self.answers objectAtIndex:indexPath.row];

	NSString *text = [NSString stringWithFormat:@"%d. %@", (indexPath.row+1), answer.question.text];
	CGSize constraint = CGSizeMake (300,700);
	CGSize size1 = [text sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	float myHeight1 = size1.height;

	NSString *text2 = answer.answer;
	NSLog(@"%@", text2);
	CGSize constraint2 = CGSizeMake (200,700);
	CGSize size2 = [text2 sizeWithFont:[UIFont fontWithName:@"Marker Felt" size:18] constrainedToSize:constraint2 lineBreakMode:UILineBreakModeWordWrap];
	float myHeight2 = size2.height;

	float myTotalHeight = myHeight1 + myHeight2 + 20;

	CGRect cellFrame = CGRectMake(0,0,myTotalHeight,320);

    GradePaperCell *cell = [[[GradePaperCell alloc] initWithFrame:cellFrame reuseIdentifier:CellIdentifier] autorelease];
	cell.delegate = self;
    
	cell.wrongButton.tag = indexPath.row;
	cell.correctButton.tag = indexPath.row;
	cell.wrongButton.alpha = 1;
	cell.correctButton.alpha = 1;
    
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
	CGSize size2 = [text2 sizeWithFont:[UIFont fontWithName:@"Marker Felt" size:18] constrainedToSize:constraint2 lineBreakMode:UILineBreakModeWordWrap];
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
	customView.backgroundColor = [UIColor whiteColor];
	
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
	[self.gradeLabel setText:@""];
	[customView addSubview:self.gradeLabel];
	//[self.gradeLabel release];
	
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

-(void)goBackwards:(id)sender {
	NSLog(@"going back");
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon popViewControllerAnimated:YES];		
	
}

-(void)goNext {
	NSLog(@"go next");
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	self.currentPaper++;
	NSString *gradeMessage = [NSString stringWithFormat:@"%@'s Grade: %@", completedWorksheet.student.firstName, gradeLabel.text];
	if (currentPaper < [completedWorksheets count]) {
		NSString *msg = [NSString stringWithFormat:@"You have %d more papers to grade. Click OK to grade the next paper.", [[delegate.teacher ungradedPapers] count]];
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:gradeMessage 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];

		//okay button handled in selector: alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	} else {
		//message that all worksheets are graded
		NSString *msg = [NSString stringWithFormat:@"You have graded all your papers! Your students will be excited to get their grades."];
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:gradeMessage
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		//go back to lounge

	}

	
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if (currentPaper < [completedWorksheets count]) {
		//show next paper
		NSLog(@"dismiss alert move on to paper #: %d", currentPaper);
		[self setCompletedWorksheet:[completedWorksheets objectAtIndex:currentPaper]];
		[self setAnswers:[[completedWorksheet answers] allObjects]];
		//reset answers graded
		NSMutableArray *anArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:2], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], nil];
		[self setAnswersGradedArray:anArray];
		[self.tableview reloadData];
		[self.tableview scrollToRowAtIndexPath:0 atScrollPosition:0 animated:YES];
	} else {
		NSLog(@"last paper. return to office with paper #%d", currentPaper);
		//go back to my office view
		[delegate.navCon popViewControllerAnimated:YES];		
	}

	

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 85;
}


@end
