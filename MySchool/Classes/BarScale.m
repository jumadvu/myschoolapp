//
//  BarScale.m
//  MySchool
//
//  Created by Ashley Kayler on 5/2/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "BarScale.h"
#import "Student.h"


@implementation BarScale

@synthesize titleLabel;
@synthesize scoreLabel;
@synthesize bar;
@synthesize student;
@synthesize type;

- (void)dealloc {
	[type release];
	[student release];
	[titleLabel release];
	[scoreLabel release];
	[bar release];
	[super dealloc];
}

- (id)initWithData:(NSString*)labelType student:(Student*)theStudent {
    CGRect frame = CGRectMake(0,400,320,80);
	
	if ((self = [self initWithFrame:frame])) {
       
    }
	//set student
	self.student = theStudent;

	NSNumber * score;
	if ([labelType isEqualToString:@"Behavior"]) {
		self.type = [NSString stringWithFormat:@"Behavior"];
		score = self.student.politeness;
	} else {
		self.type = [NSString stringWithFormat:@"Smarts"];
		score = self.student.intelligence;
	}

	self.backgroundColor = [UIColor blackColor];
	
	
	//create the bar
	UIImage *barImage = [UIImage imageNamed:@"red-green.png"];
	self.bar = [[UIImageView alloc] initWithImage:barImage];
	self.bar.frame = CGRectMake(60, 30, 200, 21);
	
	
	//create the score label
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(2*[score intValue], 0, 28, 21)];
	label.backgroundColor = [UIColor blackColor];
	label.font = [UIFont boldSystemFontOfSize:14.0];
	label.textColor = [UIColor whiteColor];
	label.textAlignment = UITextAlignmentCenter;
	label.text = [score stringValue];
	self.scoreLabel = label;
	[label release];
	
	//create the title label
	UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
	label2.backgroundColor = [UIColor clearColor];
	label2.font = [UIFont boldSystemFontOfSize:13];
	label2.textColor = [UIColor whiteColor];
	label2.textAlignment = UITextAlignmentCenter;
	label2.text = [NSString stringWithFormat:@"%@'s %@", self.student.firstName, type];
	self.titleLabel = label2;
	[label2 release];

	[self addSubview:bar];

	[bar addSubview:self.scoreLabel];
	[self addSubview:self.titleLabel];
	
	return self;
}

-(void) animateBarBy:(int)amount {
	CGAffineTransform move = CGAffineTransformMakeTranslation(2*amount, 0);
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop)];
	[self.scoreLabel setTransform:move];
	[UIView commitAnimations];
	
}

-(void)animationDidStop {
	if ([self.type isEqualToString:@"Behavior"]) {
		self.scoreLabel.text = [student.politeness stringValue];
	} else {
		self.scoreLabel.text = [student.intelligence stringValue];
	}
	
}
@end
