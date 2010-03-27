//
//  MusicFreestyle.h
//  MySchool
//
//  Created by Ashley Kayler on 3/23/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicNote;

@interface MusicFreestyle : baseViewController {
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIImageView *pie;
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
	int currentNoteNumber;
	int currentBeatNumber;
	NSMutableArray *measures;
	
}

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
@property (nonatomic) int currentNoteNumber;
@property (nonatomic) int currentBeatNumber;
@property (nonatomic, retain) NSMutableArray *measures;


- (void)setUpNotes;
-(void)addNoteToCurrentMeasureAtY:(NSNumber*)yLoc;
-(void)checkCompleteMeasure;

@end
