//
//  MusicFreestyle.m
//  MySchool
//
//  Created by Ashley Kayler on 3/23/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

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

- (void)dealloc {
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

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/





//set up the draggable notes
- (void)setUpNotes {
	// wholenote
	MusicNote *wNote = [[MusicNote alloc] init];
	[wNote setNoteType:[NSNumber numberWithFloat:1] atHeight:[NSNumber numberWithInt:1000]];
	wNote.center = CGPointMake(140, 60);
	wNote.startingPoint = CGPointMake(140, 60);
	[self setWholeNote:wNote];
	[wNote release];
	[self.view insertSubview:wholeNote belowSubview:feedback];
	
	MusicNote *hNote = [[MusicNote alloc] init];
	[hNote setNoteType:[NSNumber numberWithFloat:.5] atHeight:[NSNumber numberWithInt:1000]];
	hNote.center = CGPointMake(180, 60);
	hNote.startingPoint = CGPointMake(180, 60);
	[self setHalfNote:hNote];
	[hNote release];
	[self.view insertSubview:halfNote belowSubview:feedback];
	
	MusicNote *qNote = [[MusicNote alloc] init];
	[qNote setNoteType:[NSNumber numberWithFloat:.25] atHeight:[NSNumber numberWithInt:1000]];
	qNote.center = CGPointMake(220, 60);
	qNote.startingPoint = CGPointMake(220, 60);
	[self setQuarterNote:qNote];
	[qNote release];
	[self.view insertSubview:quarterNote belowSubview:feedback];
	
	MusicNote *eNote = [[MusicNote alloc] init];
	[eNote setNoteType:[NSNumber numberWithFloat:.125] atHeight:[NSNumber numberWithInt:1000]];
	eNote.center = CGPointMake(260, 60);
	eNote.startingPoint = CGPointMake(260, 60);
	[self setEighthNote:eNote];
	[eNote release];
	[self.view insertSubview:eighthNote belowSubview:feedback];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
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
	
	NSMutableArray *anotherArray = [[NSMutableArray alloc] init];
	[self setMeasures:anotherArray];
	[anotherArray release];
	
	//set scrollview content bounds
	CGFloat contentWidth = (widthPerMeasure * kNumMeasures) +30;
	CGFloat contentHeight = 126;
	[scrollView setContentSize:CGSizeMake(contentWidth, contentHeight)];
	[scrollView setFrame:CGRectMake(108, 102, 373, contentHeight)];
	
	for (int x=0; x<kNumMeasures; x++) {
		Measure *measure = [[Measure alloc] init];
		[measures addObject:measure];
		[self.scrollView addSubview:[measures objectAtIndex:x]];
		[measure setFrame:CGRectMake(x*360, 0, measure.measureImage.size.width, measure.measureImage.size.height)];
		[measure setDelegate:self];
		[measure release];
	}
	
	//add the pie view
	pieView = [[Pie alloc] init];
	pieView.center = CGPointMake(45, 276);
	[self.view addSubview:pieView];
	//[self.view insertSubview:pieView belowSubview:pie];
	
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch *touch = [touches anyObject];   
	
	//NSLog(@"x:%f  y:%f", location.x, location.y);
	if ([self draggedNote] != nil) {
		CGPoint location = [touch locationInView:self.view];
		draggedNote.center = CGPointMake(location.x -25, location.y);		
		return;
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches began");
	// We only support single touches, so anyObject retrieves just that touch from touches
	UITouch *touch = [touches anyObject];
	
	//set the current dragged note
	if ([touch view] == wholeNote) {
		//do something when touches begin
		[self setDraggedNote:wholeNote];
		return;
	}
	if ([touch view] == halfNote) {
		//do something when touches begin
		[self setDraggedNote:halfNote];
		return;
	}
	if ([touch view] == quarterNote) {
		//do something when touches begin
		[self setDraggedNote:quarterNote];
		return;
	}
	if ([touch view] == eighthNote) {
		//do something when touches begin
		[self setDraggedNote:eighthNote];
		return;
	}
	[self setDraggedNote:nil];
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches ended");
	UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:scrollView];
	
	if ([self draggedNote] != nil) {
		// Disable user interaction so subsequent touches don't interfere with animation
		//self.userInteractionEnabled = NO;
		draggedNote.center = draggedNote.startingPoint;
		if (location.x > 1 && location.y > -10 && location.y < 68) {
			//try and add a note to measure
			[self addNoteToCurrentMeasureAtY:[NSNumber numberWithFloat:location.y]];
			//then check to see if measure is now complete
			[self checkCompleteMeasure];
		}
	}		
}


//This is the where it all happens when a note is dropped on the scale
-(void)addNoteToCurrentMeasureAtY:(NSNumber*)yLoc {
	MusicNote *aNote = [[MusicNote alloc] init];
	[aNote setNoteType:[draggedNote fraction] atHeight:yLoc]; 
	Measure *thisMeasure = [measures objectAtIndex:currentMeasure];
	NSLog(@"how many notes: %d", [[thisMeasure measureNotes] count]);

	BOOL success = [thisMeasure tryToAddNote:aNote];
	if (!success) {
		NSString *message = [NSString stringWithFormat:@"Adding that note makes the total add up to more than one whole."];
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
			 message = [NSString stringWithFormat:@"You filled measure %d of 4. Way to go!", currentMeasure+1];
		} else {
			message = [NSString stringWithFormat:@"You completed all the measures! Click the ear to listen to your song."];
			//hide notes for dragging
			wholeNote.hidden = YES;
			halfNote.hidden = YES;
			quarterNote.hidden = YES;
			eighthNote.hidden = YES;
			pulseIsOn = YES;
			[self growButton];
		}

		NSLog(@"moving measure its full");
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
		[aMeasure playMeasure];
	} else {
		//done with song, go to where you were when you hit play button
		currentMeasure = tempCurrentMeasure;
		NSLog(@"currentMeasure: %d", currentMeasure);
		[self.scrollView setContentOffset:CGPointMake(currentMeasure* 360, 0) animated:YES];
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
	[NSThread sleepForTimeInterval:1.5];
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
		} else {
			//its the last measure
			currentMeasure--;
		}

		[fractionsLabel setText:@""];
		[pieView drawPiePiecesWithMeasure:nil];
	}
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
