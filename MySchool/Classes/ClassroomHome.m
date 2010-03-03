//
//  ClassroomHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "ClassroomHome.h"
#import "ChalkboardHome.h"
#import "StudentQuestionHome.h"
#import "PassOutWorksheets.h"
#import "Library.h"
#import "Chapter.h"
#import "User.h"
#import "UserPlus.h"
#import "Student.h"
#import "StudentPlus.h"
#import "LibraryHome.h"
#import "Lecture.h"
#import "LecturePlus.h"
#import "Keyword.h"
#import "KeywordSet.h"
#import "MainMenu.h"
#import "CompletedLesson.h"

@implementation ClassroomHome

@synthesize chalkboardButton;
@synthesize startButton;
@synthesize faster;
@synthesize slower;
@synthesize worksheetsButton;
@synthesize chapter;
@synthesize student1;
@synthesize student2;
@synthesize student3;
@synthesize student4;
@synthesize studentViews;
@synthesize teacher;
@synthesize lectureText;
@synthesize students;
@synthesize redButton;
@synthesize greenButton;
@synthesize paused;
@synthesize start;
@synthesize timerLabel;
@synthesize secondsRemaining;
@synthesize counter;
@synthesize repeatingTimer;
@synthesize scrollSpeed;
@synthesize scrollPaused;
@synthesize keywordIndex;
@synthesize scrollView;
@synthesize bonusPoints;
@synthesize completedLesson;
@synthesize currentButton;
@synthesize student0;

- (void)dealloc {
	[student0 release];
	[currentButton release];
	[scrollView release];
	[repeatingTimer release];
	[timerLabel release];
	[redButton release];
	[greenButton release];
	[students release];
	[lectureText release];
	[student1 release];
	[student2 release];
	[student3 release];
	[student4 release];
	[studentViews release];
	[teacher release];
	[worksheetsButton release];
	[startButton release];
	[chalkboardButton release];
    [super dealloc];
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setBackgroundColor];
	
	greenButton = [UIImage imageNamed:@"green_button.png"];
	redButton = [UIImage imageNamed:@"red_button.png"];
	
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[startButton setTitle:@"Begin" forState:UIControlStateNormal];
	
	//set the students
	[self setStudents:[delegate.teacher studentsArray]];
		
	//all students start happy
	[[students objectAtIndex:0] setImageView:student1 forMood:@"Happy" isWaving:NO];
	[[students objectAtIndex:1] setImageView:student2 forMood:@"Happy" isWaving:NO];
	[[students objectAtIndex:2] setImageView:student3 forMood:@"Happy" isWaving:NO];
	[[students objectAtIndex:3] setImageView:student4 forMood:@"Happy" isWaving:NO];
	
	//an array of the nib of student imageViews
	NSArray *anArray = [[NSArray alloc] initWithObjects:student1, student2, student3, student4, nil];
	[self setStudentViews:anArray];
	[anArray release];
	
	//enable interaction with students
	student1.userInteractionEnabled	= YES;
	student2.userInteractionEnabled	= YES;
	student3.userInteractionEnabled	= YES;
	student4.userInteractionEnabled	= YES;
	
	//set teacher image
	[self.teacher setImage:[delegate.teacher avatarImageWaistUp]];
	
	scrollSpeed = 5;
	
}


-(void)viewDidAppear:(BOOL)animated {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if (delegate.currentChapter == nil) {
		//go to library to choose current chapter
		LibraryHome *vc = [[[LibraryHome alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
		[delegate.navCon pushViewController:vc animated:YES];		
	}
	[self setChapter:delegate.currentChapter];
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
	self.repeatingTimer = timer;		
	paused = YES;
	scrollPaused = YES;
	secondsRemaining = 120;
	counter = 1;
	start = YES;
	keywordIndex = 0;
	bonusPoints = 0;
	completedLesson = NO;
	
	//all students start with arm down
	[[students objectAtIndex:0] setArmRaised:[NSNumber numberWithInt:0]];
	[[students objectAtIndex:1] setArmRaised:[NSNumber numberWithInt:0]];
	[[students objectAtIndex:2] setArmRaised:[NSNumber numberWithInt:0]];
	[[students objectAtIndex:3] setArmRaised:[NSNumber numberWithInt:0]];
	
	
	lectureText = [[UITextView alloc] init];
	CGRect lectureTextFrame = CGRectMake(0, 0, 200, 140.0);
	lectureText.frame = lectureTextFrame;
	lectureText.backgroundColor = [UIColor clearColor];
	lectureText.font = [UIFont systemFontOfSize:17];
	//add opening remarks
	[self.lectureText setText:[NSString stringWithFormat:@"Hello Class!\rToday we are going to talk about, %@", self.chapter.title]];
	[self.lectureText setEditable:NO];
	[scrollView addSubview:self.lectureText];
	scrollView.showsVerticalScrollIndicator = YES;
	//add main lecture text
	[self loadTextIntoScrollView];
}

-(void)loadTextIntoScrollView {
	//create a UILabel for each regular word in the text 
	//create a UIButton for each keyword
	//add these labels and buttons to the scrollview
	
	scrollView.backgroundColor = [UIColor clearColor];
	NSMutableArray *words = [[NSMutableArray alloc] init];
	NSArray *lines = [chapter.lecture.text componentsSeparatedByString:@"\n"];
	NSEnumerator *enumerator = [lines objectEnumerator];
	id obj;
	while(obj = [enumerator nextObject]) {
		[words addObjectsFromArray:[obj componentsSeparatedByString:@" "]];
	}
	NSString *word;
	int x = 0;
	int y = 130;
	int spacer = 5;
	NSEnumerator *wordEnumerator = [words objectEnumerator];
	UIColor *labelColor;
	labelColor = [UIColor clearColor]; //default
	int tagCount = 0;
	while (word = [wordEnumerator nextObject]) {
		//turn on label coloring
		if ([[word substringToIndex:1] isEqualToString:@"["]) {
			NSMutableString *buttonWord = (NSMutableString*)[word stringByReplacingOccurrencesOfString:@"[" withString:@"  "];
			while ([word rangeOfString:@"]"].location == NSNotFound) {
				word = [wordEnumerator nextObject];
				[buttonWord appendFormat:@" %@", word];
			}			
			buttonWord = (NSMutableString*)[buttonWord stringByReplacingOccurrencesOfString:@"]" withString:@"  "];

			UIButton *memberButt = [UIButton buttonWithType:UIButtonTypeCustom]; 
			memberButt.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
			memberButt.backgroundColor = [UIColor redColor];
			[memberButt setTitle:buttonWord forState:UIControlStateNormal];
			memberButt.tag = tagCount;
			[scrollView addSubview:memberButt];
			[memberButt addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];  
			memberButt.frame = CGRectMake(x, y, 145.0, 30.0);  
			[memberButt sizeToFit];
			x = x + memberButt.frame.size.width + spacer;
			if (x > (scrollView.frame.size.width-10)) {
				x = 0;
				y = y + 30;
				//move label to next row
				CGRect newFrame = CGRectMake(x, y, 140, 30.0);
				memberButt.frame = newFrame;
				[memberButt sizeToFit];
				x = x + memberButt.frame.size.width + spacer;
			}
			tagCount++;

		} else {
			UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
			label.backgroundColor = [UIColor clearColor];
			label.font = [UIFont systemFontOfSize:17];
			label.text = word;
			
			CGRect labelFrame = CGRectMake(x, y, 240, 30.0);
			label.frame = labelFrame;
			[label sizeToFit];
			x = x + label.frame.size.width + spacer;
			
			if (x > (scrollView.frame.size.width-10)) {
				x = 0;
				y = y + 30;
				//move label to next row
				CGRect newLabelFrame = CGRectMake(x, y, 240, 30.0);
				label.frame = newLabelFrame;
				[label sizeToFit];
				x = x + label.frame.size.width + spacer;
			}
			[scrollView addSubview:label];
			[label release];
		}
		
	}
	[scrollView setContentSize:CGSizeMake(200, y+30)];
	
}

//clicked on a student to answer their question
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//answer student question in modal window
	
	//scrollPaused = YES;
	
	UITouch *touch = [[UITouch alloc] init];
	touch = [touches anyObject];
	UIImageView *touchedView = (UIImageView*)touch.view;
	if (touchedView == student1) {
		NSLog(@"clicked student 1");
		[[students objectAtIndex:0] setImageView:student1 forMood:@"Happy" isWaving:NO];
	}
	if (touchedView == student2) {
		NSLog(@"clicked student 2");
		[[students objectAtIndex:1] setImageView:student2 forMood:@"Happy" isWaving:NO];
	}
	if (touchedView == student3) {
		NSLog(@"clicked student 3");
		[[students objectAtIndex:2] setImageView:student3 forMood:@"Happy" isWaving:NO];
	}
	if (touchedView == student4) {
		NSLog(@"clicked student 4");
		[[students objectAtIndex:3] setImageView:student4 forMood:@"Happy" isWaving:NO];
	}
	//[touch release];
}

-(IBAction)startEvent:(id)sender{
	NSLog(@"starting lecture");
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
	
	if (start) {
		start = NO;
		scrollPaused = NO;
		startButton.hidden = YES;
		//CGPoint scrollPoint = scrollView.contentOffset;
		//scrollPoint.y= scrollPoint.y+80;
		//[scrollView setContentOffset:scrollPoint animated:YES];
	}
	if (paused) {
		//start the timer
		[startButton setTitle:@"Pause" forState:UIControlStateNormal];
		[startButton setBackgroundImage:redButton forState:UIControlStateNormal];
		paused = NO;
		scrollPaused = NO;
	} else {
		//pause the timer
		[startButton setTitle:@"Continue" forState:UIControlStateNormal];
		[startButton setBackgroundImage:greenButton forState:UIControlStateNormal];
		paused = YES;
		scrollPaused = YES;
	}
	
}

-(void)lectureOver {
	NSLog(@"lecture over");
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
	[self.repeatingTimer invalidate];
	if (completedLesson) {
		//save this lecture to completed lectures list for this teacher
		CompletedLesson *compLesson = (CompletedLesson *)[NSEntityDescription insertNewObjectForEntityForName:@"CompletedLesson" inManagedObjectContext:delegate.managedObjectContext];
		[compLesson setPoints:[NSNumber numberWithInt:bonusPoints]];
		[compLesson setTime:[NSNumber numberWithInt:secondsRemaining]];
		[compLesson setUser:delegate.teacher];
		[compLesson setChapter:chapter];
		//add teacher's points
		[delegate.teacher setTotalPoints:[NSNumber numberWithInt:([delegate.teacher.totalPoints intValue] + bonusPoints)]];
		NSString *msg = [NSString stringWithFormat:@"Principal Wilson says:\rNice work!.\r You have earned %d points", bonusPoints];
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"You Finished the Lesson On Time!" 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	} else {
		//did not complete lesson in time.
		NSMutableString *msg = [[NSMutableString alloc] initWithFormat:@"Oops, time's up for today kids. It's time for recess. We'll do this lesson again another day."];
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Time Ran Out!" 
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		[alert show];
		[alert release];
		[msg release];

	}
	MainMenu *vc = [[[MainMenu alloc] initWithNibName:nil bundle:nil] autorelease];
	[delegate.navCon pushViewController:vc animated:YES];


}

- (void)interruption {
	//handle student question
	
}

- (void)timerFireMethod:(NSTimer*)theTimer {
	if (scrollView.contentOffset.y >= (scrollView.contentSize.height-20)) {
		//got to end of lecture
		completedLesson = YES;
		[self lectureOver];
	}
	if (!scrollPaused) {
		//scroll the text
		CGPoint scrollPoint = scrollView.contentOffset;
		scrollPoint.y= scrollPoint.y+scrollSpeed;
		[scrollView setContentOffset:scrollPoint animated:YES];		
	}
	if (!paused) {
		//find the new position for the scrolling text
		counter = counter - .2;
		
		if (counter <= 0.0) {
			secondsRemaining --;
			counter = 1.0;
		}
		self.timerLabel.text = [NSString stringWithFormat:@"%d",secondsRemaining];

		//check to see if there are any student questions
		Student *student;
		int x=0;
		for (student in students) {
			if ([student hasQuestion]) {
				[student setImageView:[studentViews objectAtIndex:x] forMood:@"Confused" isWaving:YES];
			}
			x++;
		}
		
	}
	if (secondsRemaining <= 0) {
		paused = YES;
		[self lectureOver];
	}
}


- (void)clickedButton:(UIButton *)button {
	[self setCurrentButton:button];
	if (!paused) {
		scrollPaused = YES;
		//if there is a keyword on screen, go to the highest one and display it
		keywordIndex = button.tag;
		if (keywordIndex <= [[chapter.lecture keywordSetArray] count]) {
			NSArray *words = [[[[chapter.lecture keywordSetArray] objectAtIndex:keywordIndex] words] allObjects];
			Keyword *choice1 = [words objectAtIndex:0];
			Keyword *choice2 = [words objectAtIndex:1];
			Keyword *choice3 = [words objectAtIndex:2];
			UIActionSheet *actionSheet = [[UIActionSheet alloc]
										  initWithTitle:@"Choose one!"
										  delegate:self
										  cancelButtonTitle:nil
										  destructiveButtonTitle:nil
										  otherButtonTitles:choice1.word, choice2.word, choice3.word, nil];
			[actionSheet showInView:self.view];
			[actionSheet release];
		}
	}
	button.enabled = NO;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	scrollPaused = NO;
	NSArray *words = [[[[chapter.lecture keywordSetArray] objectAtIndex:keywordIndex] words] allObjects];
	Keyword *choice1 = [words objectAtIndex:buttonIndex];
	
	if ([choice1.correct intValue] == 1) {
		NSLog(@"correct");
		bonusPoints += 10;
		//change faces to happy if student is not waving arm
		Student *student;
		int x=0;
		for (student in students) {
			if (![[student armRaised] intValue]) {
				[student setImageView:[studentViews objectAtIndex:x] forMood:@"Aha" isWaving:NO];
				//NSLog(@"here");
			}
			x++;
		}
		[currentButton setBackgroundColor:[UIColor greenColor]];
	} else {
		NSLog(@"incorrect");
		//change faces to confused
		Student *student;
		int x=0;
		for (student in students) {
			if (![[student armRaised] intValue]) {
				[student setImageView:[studentViews objectAtIndex:x] forMood:@"Confused" isWaving:NO];
				
			}
			x++;
		}
	}
	[currentButton setTitle:choice1.word forState:UIControlStateNormal];
	keywordIndex++;

}

-(void)timeRanOut {
	[self.repeatingTimer invalidate];
}




-(void)scrollSpeedPlus{
	scrollSpeed = scrollSpeed + 6;
}

-(void)scrollSpeedMinus{
	scrollSpeed = scrollSpeed - 6;
}

-(void)toChalkboard {
	//go back to previous page
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	ChalkboardHome *vc = [[[ChalkboardHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[delegate.navCon pushViewController:vc animated:YES];
	
}
-(void)toQuestion {
	//go back to previous page
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	StudentQuestionHome *vc = [[[StudentQuestionHome alloc] initWithNibName:nil bundle:nil] autorelease];
	[delegate.navCon pushViewController:vc animated:YES];
	
}
-(void)toWorksheets {
	//go back to previous page
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	PassOutWorksheets *vc = [[[PassOutWorksheets alloc] initWithNibName:nil bundle:nil] autorelease];
	[delegate.navCon pushViewController:vc animated:YES];
	
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
