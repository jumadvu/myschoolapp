//
//  MusicIntro.m
//  MySchool
//
//  Created by Ashley Kayler on 3/23/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "MusicIntro.h"
#import "MusicFreestyle.h"

@implementation MusicIntro

@synthesize level;
@synthesize instructions;
@synthesize heading;
@synthesize imageView;
@synthesize pageNum;
@synthesize continueButton;
@synthesize skipToGameButton;
@synthesize prevButton;

- (void)dealloc {
	[continueButton release];
	[prevButton release];
	[skipToGameButton release];
	[imageView release];
	[heading release];
	[instructions release];
	[level release];
    [super dealloc];
}

- (void)viewDidLoad {
	prevButton.hidden = YES;
	pageNum = 1;
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	[self setTopBarTitle:[NSString stringWithFormat:@"Instructions %d of 4", pageNum] withLogo:YES backButton:YES];
	
	[self showPage1];
    [super viewDidLoad];
}

-(void)goNext {
	pageNum++;
	[self setTopBarTitle:[NSString stringWithFormat:@"Instructions %d of 4", pageNum] withLogo:YES backButton:YES];
	prevButton.hidden = NO;
	if (pageNum == 2) {
		continueButton.hidden = NO;
		[self showPage2];
	} 
	if (pageNum == 3) {
		continueButton.hidden = NO;
		[self showPage3];		
	}
	if (pageNum == 4) {
		continueButton.hidden = YES;
		[self showPage4];		
	}
}

-(void)goPrevious {
	pageNum--;
	[self setTopBarTitle:[NSString stringWithFormat:@"Instructions %d of 4", pageNum] withLogo:YES backButton:YES];
	continueButton.hidden = NO;
	if (pageNum == 1) {
		prevButton.hidden = YES;
		[self showPage1];
	}
	if (pageNum == 2) {
		prevButton.hidden = NO;
		[self showPage2];	
	}
	if (pageNum == 3) {
		prevButton.hidden = NO;
		[self showPage3];	
	}
}

-(void)showPage1 {
	if ([level isEqualToString:@"1"]) {
		//level 1
		UIImage *myImage = [UIImage imageNamed:@"musicInstructions1.png"];
		[imageView setImage:myImage];
		heading.text = @"Instructions - 1 of 4";
		instructions.text = @"In this game you'll learn about music and math. To play the game, you'll make music by dragging notes onto a musical measure.";
	} else {
		//level 2
		heading.text = @"Make a Song";
		instructions.text = @"level two instructions";
	}
}

-(void)showPage2 {

	if ([level isEqualToString:@"1"]) {
		//level 1
		UIImage *myImage = [UIImage imageNamed:@"musicInstructions3.png"];
		[imageView setImage:myImage];
		heading.text = @"Instructions - 2 of 4";
		instructions.text = @"There are four types of notes. Each note type plays its sound for a fraction of a measure. For example, the second note below is called a half note because it fills half a measure.";
	} else {
		//level 2
		heading.text = @"Make a Song";
		instructions.text = @"level two instructions";
	}		
}

-(void)showPage3 {
	[skipToGameButton setTitle:@"Skip Instructions" forState:UIControlStateNormal];
	[skipToGameButton setTitle:@"Skip Instructions" forState:UIControlStateHighlighted];
	[skipToGameButton setTitle:@"Skip Instructions" forState:UIControlStateSelected];
	
	if ([level isEqualToString:@"1"]) {
		//level 1
		UIImage *myImage = [UIImage imageNamed:@"musicInstructions2.png"];
		[imageView setImage:myImage];
		heading.text = @"Instructions - 3 of 4";
		instructions.text = @"Your goal is to fill each measure with notes so that the total in each measure adds up to 1.  In this example, two half notes fill the measure.  1/2 + 1/2 = 1";
	} else {
		//level 2
		heading.text = @"Make a Song";
		instructions.text = @"level two instructions";
	}		
}

-(void)showPage4 {
	[skipToGameButton setTitle:@"Let's Play" forState:UIControlStateNormal];
	[skipToGameButton setTitle:@"Let's Play" forState:UIControlStateHighlighted];
	[skipToGameButton setTitle:@"Let's Play" forState:UIControlStateSelected];
	
	if ([level isEqualToString:@"1"]) {
		//level 1
		UIImage *myImage = [UIImage imageNamed:@"musicInstructions4.png"];
		[imageView setImage:myImage];
		heading.text = @"Instructions - 4 of 4";
		instructions.text = @"As you add notes to the measure, you will see a 'pie' in the corner of the screen. This will guide you on how much room is left in the measure.";
	} else {
		//level 2
		heading.text = @"Make a Song";
		instructions.text = @"level two instructions";
	}		
}


-(void)toGame {
	//hide interface
	instructions.textAlignment = UITextAlignmentCenter;
	instructions.center = CGPointMake(160, 200);
	instructions.text = @"Loading music game...";
	imageView.hidden = YES;
	skipToGameButton.hidden = YES;
	prevButton.hidden = YES;
	continueButton.hidden = YES;
	
	//show loading animation
	UIActivityIndicatorView *loadingIcon = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	loadingIcon.center = CGPointMake(160, 240);
	[loadingIcon startAnimating];
	[self.view addSubview:loadingIcon];
	[loadingIcon release];
	
	//load music game
	[NSThread detachNewThreadSelector:@selector(loadGame) toTarget:self withObject:nil];

}

- (void)loadGame {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	MusicFreestyle *vc = [[[MusicFreestyle alloc] initWithNibName:nil bundle:nil] autorelease];
	[self performSelectorOnMainThread:@selector(startGame:) withObject:vc waitUntilDone:YES];
	[pool release];
}

- (void)startGame:(MusicFreestyle*)vc {
	MySchoolAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	[delegate.navCon pushViewController:vc animated:YES];	

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
