//
//  ClassroomHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentQuestionHome.h"

@class Module;
@class Chapter;
@class Student;
@class StudentQuestionHome;
@protocol QuestionDelegate;

@interface ClassroomHome : baseViewController <UIActionSheetDelegate, UIScrollViewDelegate, QuestionDelegate> {
	IBOutlet UIButton *chalkboardButton;
	IBOutlet UIButton *startButton;
	IBOutlet UIButton *faster;
	IBOutlet UIButton *slower;
	IBOutlet UIButton *worksheetsButton;
	
	IBOutlet UIImageView *student1;
	IBOutlet UIImageView *student2;
	IBOutlet UIImageView *student3;
	IBOutlet UIImageView *student4;
	NSArray *studentViews;
	IBOutlet UIView *teacher;
	NSString *lectureText;
	IBOutlet UISlider *speedControl;
	
	IBOutlet UIScrollView *scrollView;
	
	IBOutlet Student *student0;
	
	
	IBOutlet UILabel *timerLabel;
	NSTimer *repeatingTimer;
	
	BOOL paused;
	BOOL scrollPaused;
	BOOL start;
	
	int keywordIndex;
	int whichQuestion;
	int numQuestionsAssigned;
	
	UIImage *greenButton;
	UIImage *redButton;
	UIButton *currentButton;
	
	NSArray *students;
	
	int secondsRemaining;
	float counter;
	int scrollSpeed;
	
	int bonusPoints;
	BOOL completedLesson;
	
	Chapter *chapter;

}
@property (nonatomic, retain) UISlider *speedControl;
@property (nonatomic, retain) Student *student0;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSTimer *repeatingTimer;
@property (nonatomic, retain) UILabel *timerLabel;
@property (nonatomic, retain) UIButton *currentButton;
@property (nonatomic) BOOL paused;
@property (nonatomic) BOOL scrollPaused;
@property (nonatomic) BOOL start;
@property (nonatomic) int secondsRemaining;
@property (nonatomic) int whichQuestion;
@property (nonatomic) int numQuestionsAssigned;
@property (nonatomic) float counter;
@property (nonatomic) int scrollSpeed;
@property (nonatomic) int keywordIndex;
@property (nonatomic) int bonusPoints;
@property (nonatomic) BOOL completedLesson;

@property (nonatomic, retain) UIImage *greenButton;
@property (nonatomic, retain) UIImage *redButton;

@property (nonatomic, retain) UIButton *chalkboardButton;
@property (nonatomic, retain) UIButton *startButton;
@property (nonatomic, retain) UIButton *faster;
@property (nonatomic, retain) UIButton *slower;
@property (nonatomic, retain) UIButton *worksheetsButton;
@property (nonatomic, retain) Chapter *chapter;
@property (nonatomic, retain) NSArray *students;

@property (nonatomic, retain) UIImageView *student1;
@property (nonatomic, retain) UIImageView *student2;
@property (nonatomic, retain) UIImageView *student3;
@property (nonatomic, retain) UIImageView *student4;
@property (nonatomic, retain) NSArray *studentViews;
@property (nonatomic, retain) UIView *teacher;
@property (nonatomic, retain) NSString *lectureText;

-(IBAction)toQuestion;
-(IBAction)startEvent:(id)sender;
-(void)timerFireMethod:(NSTimer*)theTimer;
-(void)timeRanOut;
-(void)loadTextIntoScrollView;
-(void)clickedButton:(UIButton *)button;
-(void)lectureOver;
-(void)answerQuestionFromStudent:(Student *)student;
- (void)dismissQuestionWindow:(NSNumber *)points;

@end
