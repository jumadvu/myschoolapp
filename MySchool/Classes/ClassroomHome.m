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

@implementation ClassroomHome

@synthesize chalkboardButton;
@synthesize startButton;
@synthesize worksheetsButton;
@synthesize chapter;
@synthesize student1;
@synthesize student2;
@synthesize student3;
@synthesize student4;
@synthesize teacher;
@synthesize lectureText;
@synthesize students;
@synthesize redButton;
@synthesize greenButton;
@synthesize paused;
@synthesize timerLabel;
@synthesize secondsRemaining;
@synthesize repeatingTimer;

- (void)dealloc {
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
	[teacher release];
	[worksheetsButton release];
	[startButton release];
	[chalkboardButton release];
    [super dealloc];
}

-(IBAction)startEvent:(id)sender{
	NSLog(@"starting lecture");
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
	
	if (paused) {
		//start the timer
		[startButton setTitle:@"Pause" forState:UIControlStateNormal];
		[startButton setBackgroundImage:redButton forState:UIControlStateNormal];
		paused = NO;
	} else {
		//pause the timer
		[startButton setTitle:@"Continue" forState:UIControlStateNormal];
		[startButton setBackgroundImage:greenButton forState:UIControlStateNormal];
		paused = YES;
	}
	
}

- (void)timerFireMethod:(NSTimer*)theTimer {
	if (!paused) {
		//[lectureText 
		secondsRemaining --;
		self.timerLabel.text = [NSString stringWithFormat:@"%d",secondsRemaining];
	}
	if (secondsRemaining <= 0) {
		[self timeRanOut];
	}
}

-(void)timeRanOut {
	[self.repeatingTimer invalidate];
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
	//[startButton setDelegate:self];
	//[startButton addTarget:self action:@selector(startEvent:) forControlEvents:UIControlEventTouchUpInside];  
	[startButton setTitle:@"Start" forState:UIControlStateNormal];
	
	[self setStudents:[delegate.teacher.students allObjects]];
	//add the lecture to teach to the database
	[self.student1 setImage:[[students objectAtIndex:0] frontView]];
	[self.student2 setImage:[[students objectAtIndex:1] frontView]];
	[self.student3 setImage:[[students objectAtIndex:2] frontView]];
	[self.student4 setImage:[[students objectAtIndex:3] frontView]];
	[self.teacher setImage:[delegate.teacher avatarImage]];
	//add modules to sqlite db
	//[Library addXMLModule:@"dinosaurs" toDatabaseContext:delegate.managedObjectContext];
}


-(void)viewDidAppear:(BOOL)animated {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if (delegate.currentChapter == nil) {
		//go to library to choose current chapter
		LibraryHome *vc = [[[LibraryHome alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
		[delegate.navCon pushViewController:vc animated:YES];		
	}
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
	self.repeatingTimer = timer;		
	paused = YES;
	secondsRemaining = 120;
	
	[self setChapter:delegate.currentChapter];
	[self.lectureText setText:self.chapter.lecture.text];
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
