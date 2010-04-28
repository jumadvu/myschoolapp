//
//  Color.m
//  MySchool
//
//  Created by Connor Riley on 4/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Color.h"


@implementation Color
@synthesize redValue, blueValue, greenButton, greenValue, redButton, blueButton, tRed, tBlue, tGreen, level, points, levVal, pointVal, targetColor, currentColor;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTopBarTitle:@"Art Class" withLogo:YES backButton:YES];
	levVal = 1;
	pointVal = 0;
	redValue = 0;
	blueValue = 0;
	greenValue = 0;
	
	[redButton setTitle:[NSString stringWithFormat:@"%d", redValue] forState:UIControlStateNormal];
	[greenButton setTitle:[NSString stringWithFormat:@"%d", greenValue] forState:UIControlStateNormal];
	[blueButton setTitle:[NSString stringWithFormat:@"%d", blueValue] forState:UIControlStateNormal];
	[level setText:[NSString stringWithFormat:@"%d", levVal]];
	[points setText:[NSString stringWithFormat:@"%d", pointVal]];
	
	[currentColor setBackgroundColor:[UIColor colorWithRed:((CGFloat)(redValue)/(CGFloat)(levVal)) green:((CGFloat)(greenValue)/(CGFloat)(levVal)) blue:((CGFloat)(blueValue)/(CGFloat)(levVal)) alpha:1.0f]];
	[self newTarget];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}
-(void)incRed{
	if(redValue<levVal){
		redValue++;
	}else{
		redValue = 0;
	}
	[self.redButton setTitle:[NSString stringWithFormat:@"%d", redValue] forState:UIControlStateNormal];
}
-(void)incBlue{
	if(blueValue<levVal){
		blueValue++;
	}else{
		blueValue = 0;
	}
	[self.blueButton setTitle:[NSString stringWithFormat:@"%d", blueValue] forState:UIControlStateNormal];
}
-(void)incGreen{
	if(greenValue<levVal){
		greenValue++;
	}else{
		greenValue = 0;
	}
	[self.greenButton setTitle:[NSString stringWithFormat:@"%d", greenValue] forState:UIControlStateNormal];
}
-(void)makeColor{
	NSLog(@"c %f %f %f", ((CGFloat)(redValue)/(CGFloat)(levVal)), ((CGFloat)(greenValue)/(CGFloat)(levVal)), ((CGFloat)(blueValue)/(CGFloat)(levVal)));
	[currentColor setBackgroundColor:[UIColor colorWithRed:((CGFloat)(redValue)/(CGFloat)(levVal)) green:((CGFloat)(greenValue)/(CGFloat)(levVal)) blue:((CGFloat)(blueValue)/(CGFloat)(levVal)) alpha:1.0f]];
	if(redValue==tRed&&greenValue==tGreen&&blueValue==tBlue){
		UIImageView *imgv = [[UIImageView alloc] init];
		[imgv setImage:[UIImage imageNamed:@"checkmark.png"]];
		[imgv setFrame:CGRectMake(10, 10, 100, 100)];
		[targetColor addSubview:imgv];
		[currentColor addSubview:imgv];
		
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[UIView setAnimationDuration:1];
		[UIView setAnimationDelegate:self];
		[currentColor setBackgroundColor:[UIColor blackColor]];
		[imgv setAlpha:0];
		[imgv release];
		[UIView commitAnimations];
		pointVal++;
		[points setText:[NSString stringWithFormat:@"%d", pointVal]];
		if(pointVal%10==0){
			levVal++;
			[level setText:[NSString stringWithFormat:@"%d", levVal]];
		}
		[self newTarget];
	}
}
-(void)newTarget{
	tRed = arc4random() % (levVal+1);
	tBlue = arc4random() % (levVal+1);
	tGreen = arc4random() % (levVal+1);
	NSLog(@"f %f %f %f", ((CGFloat)(tRed)/(CGFloat)(levVal)), ((CGFloat)(tGreen)/(CGFloat)(levVal)), ((CGFloat)(tBlue)/(CGFloat)(levVal)));
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:1];
	[UIView setAnimationDelegate:self];
	[targetColor setBackgroundColor:[UIColor colorWithRed:((CGFloat)(tRed)/(CGFloat)(levVal)) green:((CGFloat)(tGreen)/(CGFloat)(levVal)) blue:((CGFloat)(tBlue)/(CGFloat)(levVal)) alpha:1.0f]];
	[UIView commitAnimations];
}

- (void)dealloc {
	[redButton dealloc];
	[blueButton dealloc];
	[greenButton dealloc];
	[level dealloc];
	[points dealloc];
	[currentColor dealloc];
	[targetColor dealloc];
    [super dealloc];
}


@end
