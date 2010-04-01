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

#define degreesToRadian(x) (M_PI * (x) / 180.0)

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
@synthesize currentNoteNumber;
@synthesize currentBeatNumber;
@synthesize measures;
@synthesize draggedNote;
@synthesize player; // the audio player object

- (void)dealloc {
	[player release];
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
	[self.view addSubview:wholeNote];
	
	MusicNote *hNote = [[MusicNote alloc] init];
	[hNote setNoteType:[NSNumber numberWithFloat:.5] atHeight:[NSNumber numberWithInt:1000]];
	hNote.center = CGPointMake(180, 60);
	hNote.startingPoint = CGPointMake(180, 60);
	[self setHalfNote:hNote];
	[hNote release];
	[self.view addSubview:halfNote];
	
	MusicNote *qNote = [[MusicNote alloc] init];
	[qNote setNoteType:[NSNumber numberWithFloat:.25] atHeight:[NSNumber numberWithInt:1000]];
	qNote.center = CGPointMake(220, 60);
	qNote.startingPoint = CGPointMake(220, 60);
	[self setQuarterNote:qNote];
	[qNote release];
	[self.view addSubview:quarterNote];
	
	MusicNote *eNote = [[MusicNote alloc] init];
	[eNote setNoteType:[NSNumber numberWithFloat:.125] atHeight:[NSNumber numberWithInt:1000]];
	eNote.center = CGPointMake(260, 60);
	eNote.startingPoint = CGPointMake(260, 60);
	[self setEighthNote:eNote];
	[eNote release];
	[self.view addSubview:eighthNote];
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
	int numMeasures = 3;
	currentBeatNumber = 1;
	currentMeasure = 0;
	currentNoteNumber = 0;
	
	NSMutableArray *anotherArray = [[NSMutableArray alloc] init];
	[self setMeasures:anotherArray];
	[anotherArray release];
	
	//set scrollview content bounds
	CGFloat contentWidth = (widthPerMeasure * numMeasures) +30;
	CGFloat contentHeight = 126;
	[scrollView setContentSize:CGSizeMake(contentWidth, contentHeight)];
	[scrollView setFrame:CGRectMake(108, 102, 373, contentHeight)];
	
	for (int x=0; x<numMeasures; x++) {
		Measure *measure = [[Measure alloc] init];
		[measures addObject:measure];
		[self.scrollView addSubview:[measures objectAtIndex:x]];
		[measure setFrame:CGRectMake(x*360, 0, measure.measureImage.size.width, measure.measureImage.size.height)];
		[measure release];
	}
	
	//[self.scrollView setContentOffset:CGPointMake(contentWidth - 440, 0) animated:NO];
	
	//set up audio player
	NSString *soundFilePath =
	[[NSBundle mainBundle] pathForResource: @"A"
									ofType: @"mp3"];
	
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
	
	AVAudioPlayer *newPlayer =
	[[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
										   error: nil];
	[fileURL release];
	
	self.player = newPlayer;
	[newPlayer release];
	
	[player prepareToPlay];
	[player setDelegate: self];
	
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    UITouch *touch = [touches anyObject];   
	
	//NSLog(@"x:%f  y:%f", location.x, location.y);
	if ([self draggedNote] != nil) {
		CGPoint location = [touch locationInView:self.view];
		draggedNote.center = location;		
		return;
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"touches began");
	[player play];
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
	
	NSLog(@"x:%f y:%f", location.x, location.y);
	if ([self draggedNote] != nil) {
		// Disable user interaction so subsequent touches don't interfere with animation
		//self.userInteractionEnabled = NO;
		draggedNote.center = draggedNote.startingPoint;
		if (location.x > 1 && location.y > -12 && location.y < 68) {
			NSLog(@"it's on the measure");
			//add a note to measure
			[self addNoteToCurrentMeasureAtY:[NSNumber numberWithFloat:location.y]];
			[self checkCompleteMeasure];
		} else {
			NSLog(@"it's not on the measure");
			//return it to starting point
		}
	}		
}

-(void)addNoteToCurrentMeasureAtY:(NSNumber*)yLoc {
	MusicNote *aNote = [[MusicNote alloc] init];
	[aNote setNoteType:[draggedNote fraction] atHeight:yLoc]; 
	Measure *thisMeasure = [measures objectAtIndex:currentMeasure];
	NSLog(@"how many notes: %d", [[thisMeasure measureNotes] count]);

	[thisMeasure tryToAddNote:aNote];
	[aNote release];
	
	
}

-(void)checkCompleteMeasure {
	Measure *thisMeasure = [measures objectAtIndex:currentMeasure];
	[self.fractionsLabel setText:thisMeasure.mathString];		
	if ([thisMeasure isFull]) {
		//it's complete
		currentMeasure++;
		NSLog(@"moving measure its full");
		[self.scrollView setContentOffset:CGPointMake(currentMeasure* 360, 0) animated:YES];

		
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
