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

- (void)dealloc {
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
	[teacher release];
	[worksheetsButton release];
	[startButton release];
	[chalkboardButton release];
    [super dealloc];
}

-(IBAction)startEvent:(id)sender{
	NSLog(@"starting lecture");
	//MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];	
	
	if (start) {
		start = NO;
		scrollPaused = NO;
		//CGPoint scrollPoint = lectureText.contentOffset;
		//scrollPoint.y= scrollPoint.y-80;
		//[lectureText setContentOffset:scrollPoint animated:NO];
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

- (void)timerFireMethod:(NSTimer*)theTimer {
	if (!scrollPaused) {
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
	}
	if (secondsRemaining <= 0) {
		paused = YES;
		[self timeRanOut];
	}
}

- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	NSLog(@"web view click");
	return NO;
}

/*
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	NSLog(@"Web page failed to open");
}
*/


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
	if (!paused) {
		scrollPaused = YES;
		NSLog(@"should begin editing");
		NSLog(@"%d %d", textView.selectedRange.length, textView.selectedRange.location);
		//if there is a keyword on screen, go to the highest one and display it
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
	return NO;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"%d",buttonIndex);
	keywordIndex++;
	scrollPaused = NO;
	if (buttonIndex == 0) {
		//correct
		
		
	} else {
		//incorrect
	}
	
}

-(void)timeRanOut {
	[self.repeatingTimer invalidate];
}

-(void)scrollSpeedPlus{
	scrollSpeed ++;
}

-(void)scrollSpeedMinus{
	scrollSpeed --;
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
	[self.lectureText setDelegate:self];
	
	greenButton = [UIImage imageNamed:@"green_button.png"];
	redButton = [UIImage imageNamed:@"red_button.png"];

	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	//[startButton setDelegate:self];
	//[startButton addTarget:self action:@selector(startEvent:) forControlEvents:UIControlEventTouchUpInside];  
	[startButton setTitle:@"Begin" forState:UIControlStateNormal];
	
	[self setStudents:[delegate.teacher.students allObjects]];
	//add the lecture to teach to the database
	[self.student1 setImage:[[students objectAtIndex:0] frontView]];
	[self.student2 setImage:[[students objectAtIndex:1] frontView]];
	[self.student3 setImage:[[students objectAtIndex:2] frontView]];
	[self.student4 setImage:[[students objectAtIndex:3] frontView]];
	[self.teacher setImage:[delegate.teacher avatarImage]];
	
	scrollSpeed = 5;
	
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
	[self setChapter:delegate.currentChapter];
	NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
	self.repeatingTimer = timer;		
	paused = YES;
	scrollPaused = YES;
	secondsRemaining = 120;
	counter = 1;
	start = YES;
	keywordIndex = 0;
	
	lectureText = [[UITextView alloc] init];
	CGRect lectureTextFrame = CGRectMake(0, 10, 200, 150.0);
	lectureText.frame = lectureTextFrame;
	lectureText.backgroundColor = [UIColor clearColor];
	lectureText.font = [UIFont systemFontOfSize:18];
	//add opening remarks
	[self.lectureText setText:[NSString stringWithFormat:@"Hello Class!\rToday we are going to talk about...\r%@\r\r\r", self.chapter.title]];
	[self.lectureText setEditable:NO];
	[scrollView addSubview:self.lectureText];
	//add main lecture text
	[self loadTextIntoScrollView];
}

-(void)loadTextIntoScrollView {
	/*
	CGSize theSize = [text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:CGSizeMake(310.0f, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];
	NSLog(@"calculated size for %@: %f, %f",text, theSize.width, theSize.height);
	
	label = (UILabel *)[cell viewWithTag:3];
	label.text = [NSString stringWithFormat:@"%@", text];
	label.lineBreakMode = UILineBreakModeWordWrap;
	label.font = [UIFont systemFontOfSize:17.0f];
	CGSize labelSize;   
	labelSize = label.frame.size;
	NSLog(@"label size before resizing: %f, %f", labelSize.width, labelSize.height);
	[label sizeToFit];
	labelSize = label.frame.size;
	NSLog(@"label size after resizing: %f, %f for text %@", labelSize.width, labelSize.height,text);
	
	CGRect labelFrame = label.frame;
	labelFrame.size.width = 310;
	label.frame = labelFrame;
	[label sizeToFit];
	*/
	
	//create a UILabel for each word in the text.
	scrollView.backgroundColor = [UIColor clearColor];
	NSMutableArray *words = [[NSMutableArray alloc] init];
	NSArray *lines = [chapter.lecture.text componentsSeparatedByString:@"\n"];
	NSEnumerator *enumerator = [lines objectEnumerator];
	id obj;
	while(obj = [enumerator nextObject]) {
		NSLog(@"line");
		[words addObjectsFromArray:[obj componentsSeparatedByString:@" "]];
	}
	NSString *word;
	int x = 0;
	int y = 150;
	int spacer = 5;
	NSEnumerator *wordEnumerator = [words objectEnumerator];
	UIColor *labelColor;
	labelColor = [UIColor clearColor]; //default

	while (word = [wordEnumerator nextObject]) {
		//turn on label coloring
		UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
		if ([[word substringToIndex:1] isEqualToString:@"["]) {
			labelColor = [UIColor yellowColor];
		}
		
		label.backgroundColor = labelColor;
		label.font = [UIFont systemFontOfSize:16];
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
		
		NSLog(@"%@ %d", word, label.frame.size.width);
		[scrollView addSubview:label];
		//turn off label coloring
		if ([word rangeOfString:@"]"].location != NSNotFound) {
			labelColor = [UIColor clearColor];
		}
		
		[label release];
	}
	[scrollView setContentSize:CGSizeMake(200, y+30)];

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
