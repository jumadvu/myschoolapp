//
//  ClassroomHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Module;
@class Chapter;


@interface ClassroomHome : baseViewController <UITextViewDelegate, UIActionSheetDelegate, UIScrollViewDelegate> {
	IBOutlet UIButton *chalkboardButton;
	IBOutlet UIButton *startButton;
	IBOutlet UIButton *faster;
	IBOutlet UIButton *slower;
	IBOutlet UIButton *worksheetsButton;
	
	IBOutlet UIImageView *student1;
	IBOutlet UIImageView *student2;
	IBOutlet UIImageView *student3;
	IBOutlet UIImageView *student4;
	IBOutlet UIImageView *teacher;
	UITextView *lectureText;
	
	IBOutlet UIScrollView *scrollView;
	
	
	IBOutlet UILabel *timerLabel;
	NSTimer *repeatingTimer;
	
	BOOL paused;
	BOOL scrollPaused;
	BOOL start;
	
	int keywordIndex;
	
	UIImage *greenButton;
	UIImage *redButton;

	NSArray *students;
	
	int secondsRemaining;
	float counter;
	int scrollSpeed;
	
	
	Chapter *chapter;

}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSTimer *repeatingTimer;
@property (nonatomic, retain) UILabel *timerLabel;
@property (nonatomic) BOOL paused;
@property (nonatomic) BOOL scrollPaused;
@property (nonatomic) BOOL start;
@property (nonatomic) int secondsRemaining;
@property (nonatomic) float counter;
@property (nonatomic) int scrollSpeed;
@property (nonatomic) int keywordIndex;

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
@property (nonatomic, retain) UIImageView *teacher;
@property (nonatomic, retain) UITextView *lectureText;

-(IBAction)toChalkboard;
-(IBAction)toQuestion;
-(IBAction)toWorksheets;
-(IBAction)startEvent:(id)sender;
- (void)timerFireMethod:(NSTimer*)theTimer;
-(void)timeRanOut;
-(IBAction)scrollSpeedPlus;
-(IBAction)scrollSpeedMinus;
-(void)loadTextIntoScrollView;

@end
