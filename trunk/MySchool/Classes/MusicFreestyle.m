//
//  MusicFreestyle.m
//  MySchool
//
//  Created by Ashley Kayler on 3/23/10.
//  Copyright 2010 DataJedi. All rights reserved.
//
#import "MySchoolAppDelegate.h"
#import "MusicFreestyle.h"
#import "MusicNote.h"
#import "Measure.h"
#import "Pie.h"
#import <AudioToolbox/AudioServices.h>

#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define kNumMeasures 4


@implementation MusicFreestyle

@synthesize scrollView;
@synthesize pie;
@synthesize rewindButton;
@synthesize playPauseButton;
@synthesize ffButton;
@synthesize fractionsLabel;
@synthesize wholeNote;
@synthesize halfNote;
@synthesize quarterNote;
@synthesize eighthNote;
@synthesize currentMeasure;
@synthesize tempCurrentMeasure;
@synthesize currentNoteNumber;
@synthesize currentBeatNumber;
@synthesize measures;
@synthesize draggedNote;
@synthesize feedback;
@synthesize feedbackMessage;
@synthesize pieView;
@synthesize pulseIsOn;
@synthesize measureNumLabel;
@synthesize feedbackBG;

- (void)dealloc {
	[feedbackBG release];
	[measureNumLabel release];
	[pieView release];
	[feedbackMessage release];
	[draggedNote release];
	[halfNote release];
	[quarterNote release];
	[eighthNote release];
	[measures release];
	[wholeNote release];
	[fractionsLabel release];
	[scrollView release];
	[pie release];
	[rewindButton release];
	[playPauseButton release];
	[ffButton release];
	[feedback release];
    [super dealloc];
}

-(void)toMusicWelcome {
	NSLog(@"back to music welcome");
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	int count = [delegate.navCon.viewControllers count];
	[delegate.navCon popToViewController:[delegate.navCon.viewControllers objectAtIndex:count-3] animated:NO];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"music - view did load start");
    [super viewDidLoad];
	[[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];         
	if (self.interfaceOrientation == UIInterfaceOrientationPortrait) {      
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadian(90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480, 320);
	}
	fractionsLabel.text = @"";
	//create draggable notes
	[self setUpNotes];
	
	int widthPerMeasure = 360;
	//int numMeasures = 3;
	currentBeatNumber = 1;
	currentMeasure = 0;
	currentNoteNumber = 0;
	feedback.alpha = 0;
	[measureNumLabel setText:@"Measure 1"];
	
	NSMutableArray *anotherArray = [[NSMutableArray alloc] init];
	[self setMeasures:anotherArray];
	[anotherArray release];
	
	//set scrollview content bounds
	CGFloat contentWidth = (widthPerMeasure * kNumMeasures) +30;
	CGFloat contentHeight = 146;
	[scrollView setContentSize:CGSizeMake(contentWidth, contentHeight)];
	[scrollView setFrame:CGRectMake(108, 95, 373, contentHeight)];
	[scrollView setDelegate:self];
	
	for (int x=0; x<kNumMeasures; x++) {
		Measure *measure = [[Measure alloc] init];
		[measures addObject:measure];
		[self.scrollView addSubview:[measures objectAtIndex:x]];
		[measure setFrame:CGRectMake(x*360, 0, measure.measureImage.size.width, measure.measureImage.size.height+20)];
		[measure setDelegate:self];
		[measure release];
	}
	
	//add the pie view
	pieView = [[Pie alloc] init];
	pieView.center = CGPointMake(45, 276);
	[self.view addSubview:pieView];
	
	NSLog(@"music - view did load end");
}

//set up the draggable notes
- (void)setUpNotes {
	// wholenote
	MusicNote *wNote = [[MusicNote alloc] init];
	[wNote setNoteType:[NSNumber numberWithFloat:1] atHeight:[NSNumber numberWithInt:1000] atX:nil];
	wNote.center = CGPointMake(150, 40);
	wNote.startingPoint = CGPointMake(150, 40);
	[self setWholeNote:wNote];
	[wNote release];
	[self.view insertSubview:wholeNote belowSubview:feedback];
	
	MusicNote *hNote = [[MusicNote alloc] init];
	[hNote setNoteType:[NSNumber numberWithFloat:.5] atHeight:[NSNumber numberWithInt:1000] atX:nil];
	hNote.center = CGPointMake(220, 40);
	hNote.startingPoint = CGPointMake(220, 40);
	[self setHalfNote:hNote];
	[hNote release];
	[self.view insertSubview:halfNote belowSubview:feedback];
	
	MusicNote *qNote = [[MusicNote alloc] init];
	[qNote setNoteType:[NSNumber numberWithFloat:.25] atHeight:[NSNumber numberWithInt:1000] atX:nil];
	qNote.center = CGPointMake(290, 40);
	qNote.startingPoint = CGPointMake(290, 40);
	[self setQuarterNote:qNote];
	[qNote release];
	[self.view insertSubview:quarterNote belowSubview:feedback];
	
	MusicNote *eNote = [[MusicNote alloc] init];
	[eNote setNoteType:[NSNumber numberWithFloat:.125] atHeight:[NSNumber numberWithInt:1000] atX:nil];
	eNote.center = CGPointMake(360, 40);
	eNote.startingPoint = CGPointMake(360, 40);
	[self setEighthNote:eNote];
	[eNote release];
	[self.view insertSubview:eighthNote belowSubview:feedback];
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches began");
	// We only support single touches, so anyObject retrieves just that touch from touches
	UITouch *touch = [touches anyObject];
	
	//NSLog([[touch view] description]);
	//if user touches one of the four notes, set the current dragged note to that note and scroll to current measure
	if ([touch view] == wholeNote) {
		[measureNumLabel setText:[NSString stringWithFormat:@"Measure %d",currentMeasure+1]];
		[self.scrollView setContentOffset:CGPointMake(currentMeasure* 360, 0) animated:YES];
		[self setDraggedNote:wholeNote];
		return;
	}
	if ([touch view] == halfNote) {
		[measureNumLabel setText:[NSString stringWithFormat:@"Measure %d",currentMeasure+1]];
		[self.scrollView setContentOffset:CGPointMake(currentMeasure* 360, 0) animated:YES];
		[self setDraggedNote:halfNote];
		return;
	}
	if ([touch view] == quarterNote) {
		[measureNumLabel setText:[NSString stringWithFormat:@"Measure %d",currentMeasure+1]];
		[self.scrollView setContentOffset:CGPointMake(currentMeasure* 360, 0) animated:YES];
		[self setDraggedNote:quarterNote];
		return;
	}
	if ([touch view] == eighthNote) {
		[measureNumLabel setText:[NSString stringWithFormat:@"Measure %d",currentMeasure+1]];
		[self.scrollView setContentOffset:CGPointMake(currentMeasure* 360, 0) animated:YES];
		[self setDraggedNote:eighthNote];
		return;
	}
	[self setDraggedNote:nil];
	
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch *touch = [touches anyObject];   
	
	if ([self draggedNote] != nil) {
		CGPoint location = [touch locationInView:self.view];
		draggedNote.center = CGPointMake(location.x -40, location.y-20);		
		return;
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches ended");
	UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[measures objectAtIndex:currentMeasure]];
	NSLog(@"x:%f  y:%f", location.x, location.y);
	
	if ([self draggedNote] != nil) {
		draggedNote.center = draggedNote.startingPoint;
		if (location.x > 1 && location.y > 30 && location.y < 138) {
			//try and add a note to measure
			[self addNoteToCurrentMeasureAtY:[NSNumber numberWithFloat:location.y] atX:[NSNumber numberWithFloat:location.x-40]];
			//then check to see if measure is now complete
			[self checkCompleteMeasure];
		}
	}		
}


//This is the where it all happens when a note is dropped on the scale
-(void)addNoteToCurrentMeasureAtY:(NSNumber*)yLoc atX:(NSNumber*)xLoc {
	MusicNote *aNote = [[MusicNote alloc] init];
	[aNote setNoteType:[draggedNote fraction] atHeight:yLoc  atX:xLoc]; 
	
	Measure *thisMeasure = [measures objectAtIndex:currentMeasure];

	//try to add the note to the measure
	BOOL success = [thisMeasure tryToAddNote:aNote];
	
	if (!success) {
		//doesn't fit
		NSString *message = [NSString stringWithFormat:@"Oops, that note doesn't fit! Try a shorter note."];
		UIImage *fImage = [UIImage imageNamed:@"longRedBox.png"];
		[self.feedbackBG setImage:fImage];
		[self showFeedback:[NSString stringWithFormat:message]];
		//vibrate
		AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
	} else {
		//we added the note, so draw the pie
		[self.pieView drawPiePiecesWithMeasure:thisMeasure];
	}
	[aNote release];
	
	
}

-(void)checkCompleteMeasure {
	Measure *thisMeasure = [measures objectAtIndex:currentMeasure];
	//[self.fractionsLabel setText:thisMeasure.mathString];
	fractionsLabel.alpha = 0;
	[self.fractionsLabel setText:thisMeasure.mathString];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:1];
	//[UIView setAnimationDelegate:self];
	//[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	fractionsLabel.alpha = 1;
	[UIView commitAnimations];
	if ([thisMeasure isFull]) {
		//it's complete
		NSString *message;
		if (currentMeasure+1 < kNumMeasures) {
			 message = [NSString stringWithFormat:@"You filled the measure. Way to go!", currentMeasure+1];
		} else {
			message = [NSString stringWithFormat:@"You finished! Click the ear to listen to your song."];
			//hide notes for dragging
			wholeNote.hidden = YES;
			halfNote.hidden = YES;
			quarterNote.hidden = YES;
			eighthNote.hidden = YES;
			pulseIsOn = YES;
			[self growButton];
		}

		NSLog(@"moving measure its full");
		UIImage *fImage = [UIImage imageNamed:@"longGreenBox.png"];
		[self.feedbackBG setImage:fImage];
		[self showFeedback:[NSString stringWithFormat:message]];
	}
	
}

-(void)growButton {
	if (pulseIsOn) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.5];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(shrinkButton)];
		playPauseButton.transform = CGAffineTransformMakeScale(1.3,1.3);
		[UIView commitAnimations];
	}
}

-(void)shrinkButton {
	if (pulseIsOn) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.5];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(growButton)];
		playPauseButton.transform = CGAffineTransformMakeScale(1.0,1.0);
		[UIView commitAnimations];
	}
}

-(void)playMySong {
	playPauseButton.userInteractionEnabled = NO;
	pulseIsOn = NO;
	playPauseButton.transform = CGAffineTransformIdentity;
	tempCurrentMeasure = currentMeasure;
	NSLog(@"tempCurrentMeasure: %d", tempCurrentMeasure);
	//play music
	currentMeasure = -1;
	[self playNextMeasure];
}

-(void)playNextMeasure {
	currentMeasure++;
	
	BOOL shouldPlay = NO;
	
	Measure *aMeasure;
	if (currentMeasure < [measures count]) {
		aMeasure = [measures objectAtIndex:currentMeasure];
		if ([aMeasure.measureNotes count] > 0) {
			//there is at least one note in the measure
			shouldPlay = YES;
		}
	}

	if (shouldPlay) {
		//scroll to correct measure and play it
		[self.scrollView setContentOffset:CGPointMake(currentMeasure* 360, 0) animated:YES];
		[measureNumLabel setText:[NSString stringWithFormat:@"Measure %d",currentMeasure+1]];
		[aMeasure playMeasure];
	} else {
		//done with song, go to where you were when you hit play button and re-enable play button
		currentMeasure = tempCurrentMeasure;
		NSLog(@"currentMeasure: %d", currentMeasure);
		[self.scrollView setContentOffset:CGPointMake(currentMeasure* 360, 0) animated:YES];
		playPauseButton.userInteractionEnabled = YES;
		[measureNumLabel setText:[NSString stringWithFormat:@"Measure %d",currentMeasure+1]];

	}

}

-(void)showFeedback:(NSString*)message {
	feedback.alpha = 0;
	feedbackMessage.text = message;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	feedback.alpha = 1;
	[UIView commitAnimations];
	
}
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	//pause for 2 seconds
	[NSThread sleepForTimeInterval:2.5];
	//then fade it out
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(nextMeasure)];
	feedback.alpha = 0;
	[UIView commitAnimations];
}

-(void)nextMeasure {
	//returning from feedback. If the measure is full scroll to next measure
	//and clear out pie chart and fractions string
	if ([[measures objectAtIndex:currentMeasure] isFull]) {
		currentMeasure++;
		if (currentMeasure < kNumMeasures) {
			//scroll to the next measure
			[self.scrollView setContentOffset:CGPointMake(currentMeasure* 360, 0) animated:YES];
			[measureNumLabel setText:[NSString stringWithFormat:@"Measure %d",currentMeasure+1]];
		} else {
			//its the last measure
			currentMeasure--;
		}

		[fractionsLabel setText:@""];
		[pieView drawPiePiecesWithMeasure:nil];
	}
}

// At the end of scroll animation move measure to beginning of measure
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView {
	NSLog(@"scroll to beginning of measure");
	int measureNum = floor(sView.contentOffset.x / 360);
	int offset = sView.contentOffset.x;
	int offsetRemainder = offset % 360;
	if (offsetRemainder > 180) {
		measureNum++;
	}
	[sView setContentOffset:CGPointMake(measureNum*360, 0) animated:YES];
	[measureNumLabel setText:[NSString stringWithFormat:@"Measure %d",measureNum+1]];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)sView willDecelerate:(BOOL)decelerate {
	NSLog(@"scroll did end dragging");
	int measureNum = floor(sView.contentOffset.x / 360);
	int offset = sView.contentOffset.x;
	int offsetRemainder = offset % 360;
	if (offsetRemainder > 180) {
		measureNum++;
	}
	[sView setContentOffset:CGPointMake(measureNum*360, 0) animated:YES];
	[measureNumLabel setText:[NSString stringWithFormat:@"Measure %d",measureNum+1]];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return NO;
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
