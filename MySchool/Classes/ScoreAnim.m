//
//  ScoreAnim.m
//  MySchool
//
//  Created by Connor Riley on 4/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ScoreAnim.h"


@implementation ScoreAnim
@synthesize scoreValue, xValue, yValue, scoreLabel;

- (id)initWithData:(NSString*)labelvalue x:(NSNumber*)xval y:(NSNumber*)yval {
    CGRect frame = CGRectMake([xval intValue],[yval intValue],30,30);
	if ((self = [self initWithFrame:frame])) {
        [self setScoreValue:labelvalue];
		[self setYValue:yval];
		[self setXValue:xval];
    }
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
	[self setScoreLabel:label];
	[self setBackgroundColor:[UIColor clearColor]];
	[label release];
	scoreLabel.backgroundColor = [UIColor clearColor];
	scoreLabel.font = [UIFont systemFontOfSize:25.0];
	NSRange range = {0,1};
	NSString *subword = [scoreValue substringWithRange:range];
	if([subword isEqualToString:@"+"]){
		scoreLabel.textColor = [UIColor greenColor];
	}else{
		scoreLabel.textColor = [UIColor redColor];
	}
	scoreLabel.text = scoreValue;
	NSLog(@"%@", scoreValue);
	
	[self addSubview:scoreLabel];
	
	scoreLabel.alpha = 1;
	CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0f, -20.0f);

	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:2];
	[UIView setAnimationDelegate:self];
	scoreLabel.alpha = 0;
	[scoreLabel setTransform:moveUp];
	[UIView commitAnimations];
    return self;
}
-(void)drawRect:(CGRect)rect {
	// Your stuff goes here
	[super drawRect: rect];
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)drawLabel {

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[xValue release];
	[yValue release];
	[scoreLabel release];
	[scoreValue release];
    [super dealloc];
}


@end