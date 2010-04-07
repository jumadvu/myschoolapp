//
//  Measure.h
//  MySchool
//
//  Created by Ashley Kayler on 3/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class MusicNote;
@class MusicFreestyle;

@interface Measure : UIView <AVAudioPlayerDelegate>{
	UIImage *measureImage;
	NSMutableArray *measureNotes;
	NSString *mathString;
	NSNumber *nextSpace;
	int measureLength;
	int currentNote;
	AVAudioPlayer *player;
	NSArray *noteSounds;
	NSTimer *timer;
	MusicFreestyle *delegate;
}

@property (nonatomic, retain) UIImage *measureImage;
@property (nonatomic, retain) NSMutableArray *measureNotes;
@property (nonatomic, retain) NSString *mathString;
@property (nonatomic, retain) NSNumber *nextSpace;
@property (nonatomic) int measureLength;
@property (nonatomic) int currentNote;
@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSArray *noteSounds;
@property (nonatomic, retain) MusicFreestyle *delegate;

-(NSNumber*)currentSum;
-(BOOL)tryToAddNote:(MusicNote*)note;
-(BOOL)isFull;
-(NSString*)currentSumText:(NSNumber *)num;
- (void)drawRectangleWithX:(int)x Y:(int)y width:(int)width height:(float)height color:(UIColor*)myFillColor;
- (void)playNote;
- (void)playMeasure;

@end
