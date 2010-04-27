//
//  Measure.m
//  MySchool
//
//  Created by Ashley Kayler on 3/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "Measure.h"
#import "MusicNote.h"
#import "MusicFreestyle.h"
#import "Pie.h"

@implementation Measure

@synthesize measureNotes;
@synthesize measureImage;
@synthesize mathString;
@synthesize nextSpace;
@synthesize measureLength;
@synthesize player; // the audio player object
@synthesize timer;
@synthesize noteSounds;
@synthesize currentNote;
@synthesize delegate;
@synthesize draggedNote;

- (void)dealloc {
	[draggedNote release];
	[delegate release];
	[noteSounds release];
	[timer release];
	[player release];
	[nextSpace release];
	[mathString release];
	[measureNotes release];
	[measureImage release];
    [super dealloc];
}


- (id)init {
	UIImage *image = [UIImage imageNamed:@"measure.png"];
	CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height+20);
	
	// Set self's frame to encompass the image
	if (self = [self initWithFrame:frame]) {
		self.measureLength = 320;
		self.opaque = NO;
		self.measureImage = image;
		NSMutableArray *anArray = [[NSMutableArray alloc] init];
		[self setMeasureNotes:anArray];
		[anArray release];
		NSLog(@"how many notes in this measure: %d", [measureNotes count]);
		[self setNextSpace:[NSNumber numberWithInt:50]];
		
	}
	
	//set up audio players for each note
	NSURL *aURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:@"E-high" ofType:@"mp3"]];
	AVAudioPlayer *aPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: aURL error: nil];
	[aURL release];
	[aPlayer prepareToPlay];
	[aPlayer setDelegate: self];

	NSURL *bURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:@"D-high" ofType:@"mp3"]];
	AVAudioPlayer *bPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: bURL error: nil];
	[bURL release];
	[bPlayer prepareToPlay];
	[bPlayer setDelegate: self];
	
	NSURL *cURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:@"C-high" ofType:@"mp3"]];
	AVAudioPlayer *cPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: cURL error: nil];
	[cURL release];
	[cPlayer prepareToPlay];
	[cPlayer setDelegate: self];

	NSURL *dURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:@"B" ofType:@"mp3"]];
	AVAudioPlayer *dPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: dURL error: nil];
	[dURL release];
	[dPlayer prepareToPlay];
	[dPlayer setDelegate: self];

	NSURL *eURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:@"A" ofType:@"mp3"]];
	AVAudioPlayer *ePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: eURL error: nil];
	[eURL release];
	[ePlayer prepareToPlay];
	[ePlayer setDelegate: self];

	NSURL *fURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:@"G-middle" ofType:@"mp3"]];
	AVAudioPlayer *fPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: fURL error: nil];
	[fURL release];
	[fPlayer prepareToPlay];
	[fPlayer setDelegate: self];

	NSURL *gURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:@"F-middle" ofType:@"mp3"]];
	AVAudioPlayer *gPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: gURL error: nil];
	[gURL release];
	[gPlayer prepareToPlay];
	[gPlayer setDelegate: self];

	[self setNoteSounds:[NSArray arrayWithObjects:aPlayer, bPlayer, cPlayer, dPlayer, ePlayer, fPlayer, gPlayer, nil]];

	//[aPlayer release];
	//[bPlayer release];
	
	return self;
	
}

-(NSNumber*)currentSum {
	MusicNote *note;
	float sum = 0;
	for (note in measureNotes) {
		sum = sum + [note.fraction floatValue];
	}
	return [NSNumber numberWithFloat:sum];
}

- (void)timerFireMethod:(NSTimer*)theTimer {
	[player stop];
}


-(BOOL)tryToAddNote:(MusicNote*)note {
	BOOL addedNote = NO;
	NSLog(@"trying to add note");
	float newSum = [[self currentSum] floatValue] + [note.fraction floatValue];
	if (newSum <= 1) {
		//add the note to the measure
		[measureNotes addObject:note];
		[self addSubview:note];
		
		/*
		note.center = CGPointMake([nextSpace intValue], [note.height intValue]);
		int spacer = [nextSpace intValue] + measureLength * [note.fraction floatValue];
		[self setNextSpace:[NSNumber numberWithInt:spacer]];
		 */
		
		//play the sound
		NSLog(@"%d", note.noteNum);
		self.player = [noteSounds objectAtIndex:note.noteNum];
		[player play];

		//set a timer to stop the note after the correct interval
		NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:2*[note.fraction floatValue] target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO];
		[self setTimer:aTimer];
		
		//arrange notes
		[self moveNotesIntoPosition];
		
		addedNote = YES;
	}
	if (newSum == 1) {
		//measure is full. add green border to measure
		[self setNeedsDisplay];
		
	}
	if (newSum > 1) {
		//can't fit this note. show feedback.
	}
	
	//show math
	MusicNote *enote;
	NSMutableString *mString = [[NSMutableString alloc] init];
	int count = 0;
	for (enote in measureNotes) {
		if (count != 0) {
			[mString appendString:[NSString stringWithFormat:@" + "]];
		}
		[mString appendString:enote.fractionString];
		count++;
	}
	if ([measureNotes count] > 1) {
		[mString appendString:[NSString stringWithFormat:@" = %@", [self currentSumText:[self currentSum]]]];
	}
	[self setMathString:(NSString*)mString];
	
	return addedNote;
}

-(BOOL)isFull {
	if ([[self currentSum] intValue] == 1) {
		return YES;
	} else {
		return NO;
	}
}

-(NSString*)currentSumText:(NSNumber *)num {
	NSString *sumText = [[[NSString alloc] init] autorelease];
	if ([num floatValue] == 1) {
		sumText = @"1";	
	}
	if ([num floatValue] == .5) {
		sumText = @"1/2";	
	}
	if ([num floatValue] == .25) {
		sumText = @"1/4";	
	}
	if ([num floatValue] == .75) {
		sumText = @"3/4";	
	}
	if ([num floatValue] == .125) {
		sumText = @"1/8";	
	}
	if ([num floatValue] == .375) {
		sumText = @"3/8";	
	}
	if ([num floatValue] == .625) {
		sumText = @"5/8";	
	}
	if ([num floatValue] == .875) {
		sumText = @"7/8";	
	}
	return sumText;
	
}

- (void)drawRectangleWithX:(int)x Y:(int)y width:(int)width height:(float)height color:(UIColor*)myFillColor {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[[UIColor clearColor] setFill];
	[myFillColor setStroke];
	CGContextSetLineWidth(context, 5);
	
	//draw rectangle
	CGContextBeginPath(context);
	CGPoint thePoint = CGPointMake(x, y);
	CGPoint thePoint2 = CGPointMake(x+width, y);
	CGPoint thePoint3 = CGPointMake(x+width, y+height);
	CGPoint thePoint4 = CGPointMake(x, y+height);
	CGContextMoveToPoint(context, thePoint.x, thePoint.y);
	CGContextAddLineToPoint(context, thePoint2.x, thePoint2.y);
	CGContextAddLineToPoint(context, thePoint3.x, thePoint3.y);
	CGContextAddLineToPoint(context, thePoint4.x, thePoint4.y);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	NSLog(@"drawing rect");
	[measureImage drawAtPoint:(CGPointMake(0.0, 0.0))];
	
	//if its a complete measure draw a green rectangle
	if ([[self currentSum] intValue] == 1) {
		[self drawRectangleWithX:0 Y:45 width:356 height:78 color:[UIColor greenColor]];
	}
	
}

- (void)playMeasure {
	//plays all the notes in the measure starting with the first note
	currentNote = -1;
	[self playNote];
}

- (void)playNote {
	MusicNote *myNote;
	for (myNote in measureNotes) {
		myNote.transform = CGAffineTransformIdentity;
	}
	[player stop];
	currentNote++;
	if (currentNote < [measureNotes count]) {
		NSLog(@"playing measure: %d  note:%d", delegate.currentMeasure, currentNote);
		MusicNote *note = [measureNotes objectAtIndex:currentNote];
		self.player = [self.noteSounds objectAtIndex:note.noteNum];
		[player play];
		NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:2*[note.fraction floatValue] target:self selector:@selector(playNote) userInfo:nil repeats:NO];
		[self setTimer:aTimer];
		//make the note a bit bigger
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.1];
		note.transform = CGAffineTransformMakeScale(1.2,1.2);
		[UIView commitAnimations];
	} else {
		//done with measure, send message to play next measure
		[delegate playNextMeasure];
	}

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches began");
	// We only support single touches, so anyObject retrieves just that touch from touches
	UITouch *touch = [touches anyObject];
	
	//NSLog([[touch view] description]);

	for (int x=0; x<[self.measureNotes count]; x++) {
		MusicNote *aNote = [self.measureNotes objectAtIndex:x];
		NSLog(@"trying note %d", x);
		if ([touch view] == aNote) {
			NSLog(@"it's a placed note");
			//disable movement of measure
			delegate.scrollView.scrollEnabled = NO;
			//do something when touches begin
			[self setDraggedNote:aNote];
			return;
		}
	}
	
	
	
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch *touch = [touches anyObject];   
	
	
	if ([self draggedNote] != nil) {
		CGPoint location = [touch locationInView:self];
		//NSLog(@"x:%f  y:%f", location.x, location.y);
		if (location.y > 115) {
			draggedNote.center = CGPointMake(location.x -30, 90);		
		} else if (location.y < 53) {
			draggedNote.center = CGPointMake(location.x -30, 28);		
		} else {
			draggedNote.center = CGPointMake(location.x -30, location.y-25);		
		}
		return;
	}
	 
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches ended");
	UITouch *touch = [touches anyObject];
	
    //CGPoint location = [touch locationInView:self];
	if ([self draggedNote] != nil) {
		CGPoint location = CGPointMake(draggedNote.center.x, draggedNote.center.y+25);
		//reattach note to measure
		[self reattachNote:(MusicNote*)draggedNote atY:[NSNumber numberWithFloat:location.y] atX:[NSNumber numberWithFloat:location.x]];
		delegate.scrollView.scrollEnabled = YES;
	}
	draggedNote = nil;
}

-(void)reattachNote:(MusicNote*)note atY:(NSNumber*)yLoc atX:(NSNumber*)xLoc {
	NSLog(@"reattaching note to measure");
	if ([yLoc intValue] > 50 && [yLoc intValue] < 120) {
		NSLog(@"y:%2f", [yLoc floatValue]);
		[note setNoteType:[note fraction] atHeight:yLoc atX:xLoc];
		note.center = CGPointMake(note.center.x, [note.height intValue]);		
		
		//play the sound
		NSLog(@"note num: %d", note.noteNum);
		self.player = [noteSounds objectAtIndex:note.noteNum];
		[player play];
		
		//set a timer to stop the note after the correct interval
		NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:2*[note.fraction floatValue] target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO];
		[self setTimer:aTimer];
		
		[self moveNotesIntoPosition];
		[delegate.pieView drawPiePiecesWithMeasure:self];

		
	} else {
		//not in bounds, return to original y position
		NSLog(@"not in bounds");
		NSLog(@"y:%2f", [yLoc floatValue]);
	}

}

-(void)moveNotesIntoPosition {
	int numNotes = [measureNotes count];
	numNotes++;
	MusicNote *aNote;
	int count = 1;
	for (aNote in measureNotes) {
		[aNote setNewPoint:CGPointMake(count*(measureLength/numNotes), [aNote.height intValue])];
		//[aNote setNeedsDisplay]
		[self animateNote:aNote];
		
		[aNote setStartingPoint:aNote.newPoint];
		count++;
	}
	
}
		 
-(void)animateNote:(MusicNote*)note {
	float xFactor = note.newPoint.x - note.startingPoint.x;
	float yFactor = note.newPoint.y - note.startingPoint.y;
	note.center = CGPointMake(note.startingPoint.x, note.startingPoint.y);		

	NSLog(@"starting point x: %2f",note.startingPoint.x);
	NSLog(@"new point x: %2f",note.newPoint.x);
	NSLog(@"final point x: %2f",xFactor);
	
	//CGAffineTransform moveIt = CGAffineTransformMakeTranslation(xFactor, yFactor);	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:.5];
	[UIView setAnimationDelegate:self];
	//[note setTransform:moveIt];
	note.center = CGPointMake(note.newPoint.x, note.newPoint.y);		
	
	[UIView commitAnimations];
	
}
		 
@end
