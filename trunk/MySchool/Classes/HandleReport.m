//
//  HandleReport.m
//  MySchool
//
//  Created by Ashley Kayler on 4/19/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "HandleReport.h"
#import "BehaviorReport.h"
#import "BehaviorReportPlus.h"
#import "UserPlus.h"
#import "User.h"
#import "StudentReports.h"
#import "Student.h"
#import "StudentPlus.h"
#import "ScoreAnim.h"
#import "AvatarPlus.h"
#import "MySchoolAppDelegate.h"
#import "BarScale.h"

@implementation HandleReport

@synthesize teacherAtDesk;
@synthesize report;
@synthesize answer1Correct;
@synthesize delegate;
@synthesize gotItRight;
@synthesize clicked;
@synthesize behaviorBar;

- (void)dealloc {
	[delegate release];
	[report release];
	[teacherAtDesk release];
	[behaviorBar release];
    [super dealloc];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[self setBackgroundColor];
	[self setTopBarTitle:@"What Should You Do?" withLogo:NO backButton:NO];
	MySchoolAppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];

	//add teacher icon
	[self.teacherAtDesk addSubview:[appdelegate.teacher.avatar customAvatarAtSize:.6]];
	
	//add student respect bar
	BarScale *bar = [[BarScale alloc] initWithData:@"Behavior" student:delegate.student];
	[self setBehaviorBar:bar];
	[self.view addSubview:behaviorBar];
	[bar release];
	
	//default
	gotItRight = NO;
	clicked = NO;
	
	//randomize answer
	int i = arc4random() % 2;
	NSString *answer1;
	NSString *answer2;
	if (i == 1) {
		answer1Correct = YES;
		answer1 = [BehaviorReport replaceName:delegate.student.firstName gender:delegate.student.gender inText:report.correct];
		answer2 = [BehaviorReport replaceName:delegate.student.firstName gender:delegate.student.gender inText:report.wrong];
	} else {
		answer1Correct = NO;
		answer1 = [BehaviorReport replaceName:delegate.student.firstName gender:delegate.student.gender inText:report.wrong];
		answer2 = [BehaviorReport replaceName:delegate.student.firstName gender:delegate.student.gender inText:report.correct];
	}

	//figure out answer1 height
	NSString *text = [NSString stringWithFormat:answer1];
	CGSize constraint = CGSizeMake (110,700);
	CGSize size1 = [text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	float myHeight1 = size1.height + 40;

	//figure out answer2 height
	NSString *text2 = [NSString stringWithFormat:answer2];
	CGSize constraint2 = CGSizeMake (110,700);
	CGSize size2 = [text2 sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:constraint2 lineBreakMode:UILineBreakModeWordWrap];
	float myHeight2 = size2.height + 40;
	
	UIButton *a1Button = [UIButton buttonWithType:UIButtonTypeCustom]; 
	a1Button.titleLabel.numberOfLines = 0;
	a1Button.titleLabel.lineBreakMode   = UILineBreakModeWordWrap;
	UIImage *buttonImageNormal2 = [UIImage imageNamed:@"bluebutton.png"];
	UIImage *stretchableButtonImageNormal2 = [buttonImageNormal2 stretchableImageWithLeftCapWidth:12 topCapHeight:12];
	a1Button.titleLabel.font = [UIFont systemFontOfSize:13.0];
	a1Button.titleEdgeInsets = UIEdgeInsetsMake(5.0, 10.0, 10.0, 10.0);
	//a1Button.titleLabel.shadowOffset    = CGSizeMake (.5, .5);
	//a1Button.titleLabel.textColor = [UIColor blackColor];
	[a1Button setTitle:answer1 forState:UIControlStateNormal];
	[a1Button setBackgroundImage:stretchableButtonImageNormal2 forState:UIControlStateNormal];
	CGRect frame2 = CGRectMake(10, 45, 130.0, myHeight1);
	a1Button.frame = frame2;	
	[a1Button addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];  
	a1Button.tag = 0;
	[self.view addSubview:a1Button];
	
	UIButton *a2Button = [UIButton buttonWithType:UIButtonTypeCustom]; 
	a2Button.titleLabel.numberOfLines = 6;
	a2Button.titleLabel.lineBreakMode   = UILineBreakModeWordWrap;
	UIImage *buttonImageNormal3 = [UIImage imageNamed:@"bluebutton.png"];
	UIImage *stretchableButtonImageNormal3 = [buttonImageNormal3 stretchableImageWithLeftCapWidth:12 topCapHeight:12];
	a2Button.titleLabel.font = [UIFont systemFontOfSize:13.0];
	//a1Button.titleLabel.shadowOffset    = CGSizeMake (.5, .5);
	//a1Button.titleLabel.textColor = [UIColor blackColor];
	a2Button.titleEdgeInsets = UIEdgeInsetsMake(5.0, 10.0, 10.0, 10.0);
	[a2Button setTitle:answer2 forState:UIControlStateNormal];
	CGRect frame3 = CGRectMake(190, 45, 130.0, myHeight2);
	a2Button.frame = frame3;	
	[a2Button setBackgroundImage:stretchableButtonImageNormal3 forState:UIControlStateNormal];
	[a2Button addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];  
	a2Button.tag = 1;
	[self.view addSubview:a2Button];
	
}


- (void)clickedButton:(UIButton *)button {
	int keywordIndex = button.tag;
	MySchoolAppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
	
	//check this is the first button clicked
	if (!clicked) {
		
		if ((keywordIndex == 0 && answer1Correct) || (keywordIndex == 1 && !answer1Correct)) {
			//got it right. add student behavior point
			[delegate.student adjustBehavior:@"positive"];
			gotItRight = YES;
			ScoreAnim *anim = [[ScoreAnim alloc] initWithData:@"+2 Behavior" x:[NSNumber numberWithInt:115] y:[NSNumber numberWithInt:300]];
			[self.view addSubview:anim];
			[anim release];
			[behaviorBar animateBarBy:2];
		} else {
			//got it wrong. subtract student behavior point
			[delegate.student adjustBehavior:@"negative"];
			gotItRight = NO;
			ScoreAnim *anim = [[ScoreAnim alloc] initWithData:@"-2 Behavior" x:[NSNumber numberWithInt:115] y:[NSNumber numberWithInt:300]];
			[self.view addSubview:anim];
			[anim release];
			[behaviorBar animateBarBy:-2];
		}

		clicked = YES;
		
		
		//delay until the feedback has shown, then dismiss modal window
		[NSTimer scheduledTimerWithTimeInterval:2.5 target:self 
										selector:@selector(returnToPreviousPage) userInfo:nil repeats:NO];
	} else {
		//do nothing if they click a second button
	}

 
	
}


-(void) returnToPreviousPage{
	if ([self.delegate respondsToSelector:@selector(dismissQuestionWindow:)]) {
		[self.delegate dismissQuestionWindow:gotItRight];
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
