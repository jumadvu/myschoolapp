//
//  StudentQuestionHome.m
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//
#import "MySchoolAppDelegate.h"
#import "StudentQuestionHome.h"
#import "UserPlus.h"
#import "StudentPlus.h"
#import "Student.h"
#import "User.h"
#import "ChapterPlus.h"
#import "StudentQuestion.h"
#import "StudentQuestionPlus.h"
#import "StudentAnswer.h"
#import "ClassroomHome.h"
#import "AvatarPlus.h"
#import "BarScale.h"
#import "PersonalQuestion.h"
#import "Library.h"

@implementation StudentQuestionHome

@synthesize studentView;
@synthesize teacherView;
@synthesize student;
@synthesize chapter;
@synthesize sButton;
@synthesize a1Button, a2Button, a3Button;
@synthesize whichQuestion;
@synthesize delegate;
@synthesize bar;
@synthesize answerKey;

- (void)dealloc {
	[bar release];
	[a1Button release];
	[a2Button release];
	[a3Button release];
	[sButton release];
	[studentView release];
	[teacherView release];
	[student release];
	[chapter release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];

	MySchoolAppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];

	//set teacher and student images
	[self.teacherView addSubview:[appdelegate.teacher.avatar customAvatarAtSize:.7]];
	[student setImageView:self.studentView forMood:@"Happy" isWaving:NO];

	/*
	//add student intelligence barscale
	BarScale *barScale = [[BarScale alloc] initWithData:@"Smarts" student:student];
	[self setBar:barScale];
	[self.view addSubview:self.bar];
	[barScale release];
	 */
	
	NSString *question;
	NSString *answer1;
	NSString *answer2;

	if (whichQuestion == 100) {
		//personal question
		PersonalQuestion *pQuestion = (PersonalQuestion*)[Library fetchPersonalQuestion];
		question = pQuestion.question;
		int randomNum = arc4random() % 2;
		if (randomNum == 1) {
			answer1 = [NSString stringWithFormat:@"%@", pQuestion.correct];
			answer2 = [NSString stringWithFormat:@"%@", pQuestion.wrong];
		} else {
			answer2 = [NSString stringWithFormat:@"%@", pQuestion.correct];
			answer1 = [NSString stringWithFormat:@"%@", pQuestion.wrong];
		}

	} else {
		//academic question
		StudentQuestion *sQuestion = [[chapter studentQuestionsArray] objectAtIndex:whichQuestion];
		question = [NSString stringWithFormat:@"%@, %@", [appdelegate.teacher title],[sQuestion text]];
		answer1 = [NSString stringWithFormat:@"%@",[[[sQuestion studentAnswersArray] objectAtIndex:0] answer]];
		answer2 = [NSString stringWithFormat:@"%@",[[[sQuestion studentAnswersArray] objectAtIndex:1] answer]];
	}
	//set up question
	sButton.titleLabel.numberOfLines = 6;
	sButton.titleLabel.lineBreakMode   = UILineBreakModeWordWrap;
	sButton.titleLabel.shadowOffset    = CGSizeMake (.5, .5);
	UIImage *buttonImageNormal = [UIImage imageNamed:@"smallspeechbubble.png"];
	UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:31 topCapHeight:0];
	sButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
	sButton.titleEdgeInsets = UIEdgeInsetsMake(10.0, 35.0, 10.0, 15.0);
	[sButton setTitle:question forState:UIControlStateNormal];
	[sButton setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
	CGRect frame = CGRectMake(100, 30.0, 210.0, sButton.frame.size.height+35);
	sButton.frame = frame;	

	//set up answers
	a1Button.titleLabel.numberOfLines = 6;
	a1Button.titleLabel.lineBreakMode   = UILineBreakModeWordWrap;
	UIImage *buttonImageNormal2 = [UIImage imageNamed:@"yellowbutton.png"];
	UIImage *stretchableButtonImageNormal2 = [buttonImageNormal2 stretchableImageWithLeftCapWidth:12 topCapHeight:19];
	a1Button.titleLabel.font = [UIFont systemFontOfSize:14.0];
	a1Button.titleEdgeInsets = UIEdgeInsetsMake(8.0, 10.0, 8.0, 10.0);
	[a1Button setTitle:answer1 forState:UIControlStateNormal];
	[a1Button setBackgroundImage:stretchableButtonImageNormal2 forState:UIControlStateNormal];
	CGRect frame2 = CGRectMake(10, 10.0, 180.0, a1Button.frame.size.height+45);
	a1Button.frame = frame2;	
	[a1Button addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];  

	a2Button.titleLabel.numberOfLines = 6;
	a2Button.titleLabel.lineBreakMode   = UILineBreakModeWordWrap;
	UIImage *buttonImageNormal3 = [UIImage imageNamed:@"yellowbutton.png"];
	UIImage *stretchableButtonImageNormal3 = [buttonImageNormal3 stretchableImageWithLeftCapWidth:12 topCapHeight:19];
	a2Button.titleLabel.font = [UIFont systemFontOfSize:14.0];
	a2Button.titleEdgeInsets = UIEdgeInsetsMake(8.0, 10.0, 8.0, 10.0);
	[a2Button setTitle:answer2 forState:UIControlStateNormal];
	[a2Button setBackgroundImage:stretchableButtonImageNormal3 forState:UIControlStateNormal];
	CGRect frame3 = CGRectMake(10, a1Button.frame.size.height + 25, 180.0, a2Button.frame.size.height+45);
	a2Button.frame = frame3;	
	[a2Button addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];  
	
	
}


- (void)clickedButton:(UIButton *)button {
	self.answerKey = button.tag;
	if (whichQuestion == 100) {
		//personal question. Always show happy face.
		[self.student setImageView:self.studentView forMood:@"Happy" isWaving:NO];		
	} else {
		//academic queston
		StudentQuestion *sQuestion = [[chapter studentQuestionsArray] objectAtIndex:whichQuestion];
		StudentAnswer *sAnswer = [[sQuestion studentAnswersArray] objectAtIndex:self.answerKey];
		
		//if the answer is correct, show 'Aha'. If not show confused look.
		if ([[sAnswer correctness] intValue] > 0) {
			//correct
			[self.student setImageView:self.studentView forMood:@"Aha" isWaving:NO];		
		} else {
			//wrong
			[self.student setImageView:self.studentView forMood:@"Confused" isWaving:NO];
		}
	}


	//delay for a second to show student expression
	[NSTimer scheduledTimerWithTimeInterval:1.6 target:self 
								   selector:@selector(returnToPreviousPage) userInfo:nil repeats:NO];

}

-(void) returnToPreviousPage{
	if (whichQuestion == 100) {
		//personal question. Always show happy face.
		[self.student setImageView:self.studentView forMood:@"Happy" isWaving:NO];		
		if ([self.delegate respondsToSelector:@selector(dismissQuestionWindow:)]) {
			[self.delegate dismissQuestionWindow:nil];
		}
	} else {
		//academic question
		StudentQuestion *sQuestion = [[chapter studentQuestionsArray] objectAtIndex:whichQuestion];
		StudentAnswer *sAnswer = [[sQuestion studentAnswersArray] objectAtIndex:self.answerKey];
		if ([self.delegate respondsToSelector:@selector(dismissQuestionWindow:)]) {
			[self.delegate dismissQuestionWindow:[sAnswer correctness]];
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
