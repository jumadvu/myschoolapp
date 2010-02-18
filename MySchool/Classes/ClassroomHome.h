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


@interface ClassroomHome : baseViewController {
	IBOutlet UIButton *chalkboardButton;
	IBOutlet UIButton *startButton;
	IBOutlet UIButton *worksheetsButton;
	
	IBOutlet UIImageView *student1;
	IBOutlet UIImageView *student2;
	IBOutlet UIImageView *student3;
	IBOutlet UIImageView *student4;
	IBOutlet UIImageView *teacher;
	IBOutlet UITextView *lectureText;
	
	IBOutlet UILabel *timerLabel;
	NSTimer *repeatingTimer;
	
	BOOL paused;
	
	UIImage *greenButton;
	UIImage *redButton;

	NSArray *students;
	
	int secondsRemaining;
	
	
	Chapter *chapter;

}

@property (nonatomic, retain) NSTimer *repeatingTimer;
@property (nonatomic, retain) UILabel *timerLabel;
@property (nonatomic) BOOL paused;
@property (nonatomic) int secondsRemaining;

@property (nonatomic, retain) UIImage *greenButton;
@property (nonatomic, retain) UIImage *redButton;

@property (nonatomic, retain) UIButton *chalkboardButton;
@property (nonatomic, retain) UIButton *startButton;
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

@end
