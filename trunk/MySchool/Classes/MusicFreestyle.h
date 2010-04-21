//
//  MusicFreestyle.h
//  MySchool
//
//  Created by Ashley Kayler on 3/23/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class MusicNote;
@class Pie;

@interface MusicFreestyle : baseViewController {
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIImageView *pie;
	IBOutlet UIView *feedback;
	IBOutlet UITextView *feedbackMessage;
	IBOutlet UIButton *rewindButton;
	IBOutlet UIButton *playPauseButton;
	IBOutlet UIButton *ffButton;
	IBOutlet UILabel *fractionsLabel;
	MusicNote *wholeNote;
	MusicNote *halfNote;
	MusicNote *quarterNote;
	MusicNote *eighthNote;
	MusicNote *draggedNote;
	int currentMeasure;
	int tempCurrentMeasure;
	int currentNoteNumber;
	int currentBeatNumber;
	NSMutableArray *measures;
	Pie *pieView;
	BOOL pulseIsOn;
	
}

@property (nonatomic, retain) UITextView *feedbackMessage;
@property (nonatomic, retain) UIView *feedback;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *pie;
@property (nonatomic, retain) UIButton *rewindButton;
@property (nonatomic, retain) UIButton *playPauseButton;
@property (nonatomic, retain) UIButton *ffButton;
@property (nonatomic, retain) UILabel *fractionsLabel;
@property (nonatomic, retain) MusicNote *wholeNote;
@property (nonatomic, retain) MusicNote *halfNote;
@property (nonatomic, retain) MusicNote *quarterNote;
@property (nonatomic, retain) MusicNote *eighthNote;
@property (nonatomic, retain) MusicNote *draggedNote;
@property (nonatomic) int currentMeasure;
@property (nonatomic) int tempCurrentMeasure;
@property (nonatomic) int currentNoteNumber;
@property (nonatomic) int currentBeatNumber;
@property (nonatomic) BOOL pulseIsOn;
@property (nonatomic, retain) NSMutableArray *measures;
@property (nonatomic, retain) Pie *pieView;


- (void)setUpNotes;
-(void)addNoteToCurrentMeasureAtY:(NSNumber*)yLoc;
-(void)checkCompleteMeasure;
-(void)showFeedback:(NSString*)message;
-(IBAction)playMySong;
-(void)playNextMeasure;
-(void)growButton;
-(void)shrinkButton;
-(IBAction) toMusicWelcome;

@end
