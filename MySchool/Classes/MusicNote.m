//
//  MusicNote.m
//  MySchool
//
//  Created by Ashley Kayler on 3/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "MusicNote.h"


@implementation MusicNote

@synthesize myString;
@synthesize noteImage;
@synthesize startingPoint;
@synthesize newPoint;
@synthesize fraction;
@synthesize height;
@synthesize name;
@synthesize fractionString;
@synthesize noteNum;
@synthesize color;

- (void)dealloc {
	[color release];
	[fractionString release];
	[height release];
	[name release];
	[fraction release];
	[myString release];
	[noteImage release];
    [super dealloc];
}

- (id)init {
	CGRect frame = CGRectMake(0, 0, 37, 70);
	
	// Set self's frame to encompass the image
	if (self = [self initWithFrame:frame]) {
		
		self.opaque = NO;
		
	}
	return self;
	
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	[noteImage drawAtPoint:(CGPointMake(0.0, 0.0))];

}

-(void)setFractionStringText:(NSNumber *)num {
	if ([num floatValue] == 1) {
		[self setFractionString:@"1"];	
		return;
	}
	if ([num floatValue] == .5) {
		[self setFractionString:@"1/2"];	
		return;
	}
	if ([num floatValue] == .25) {
		[self setFractionString:@"1/4"];	
		return;
	}
	[self setFractionString:@"1/8"];	
	
}


-(void)setNoteType:(NSNumber*)type atHeight:(NSNumber*)dropHeight atX:(NSNumber*)xVal {
	//note type is fraction
	//smallest accepted value 30  max 118
	int min = 47;
	int spacer = 11;
	int startHeight = 16;
	
	[self setFraction:type];
	[self setFractionStringText:type];
	int h = [dropHeight intValue];
	int x = [xVal intValue];
	if (h == 1000) {
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"black" type:type]];
		[self setNoteImage:image];	
	}
	if (h < min+10) {
		[self setHeight:[NSNumber numberWithInt:startHeight+(1*spacer)]];
		[self setName:[NSString stringWithFormat:@"E"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"red" type:type]];
		[self setNoteImage:image];
		[self setNoteNum:0];
		[self setColor:[UIColor colorWithRed:1 green:.1 blue:.1 alpha:1]];
	}
	if (h >= min+10 && h < min+20) {
		[self setHeight:[NSNumber numberWithInt:startHeight+(2*spacer)]];
		[self setName:[NSString stringWithFormat:@"D"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"orange" type:type]];
		[self setNoteImage:image];	
		[self setNoteNum:1];
		[self setColor:[UIColor orangeColor]];
	}
	if (h >= min+20 && h < min+30) {
		[self setHeight:[NSNumber numberWithInt:startHeight+(3*spacer)]];
		[self setName:[NSString stringWithFormat:@"C"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"yellow" type:type]];
		[self setNoteImage:image];	
		[self setNoteNum:2];
		[self setColor:[UIColor yellowColor]];
	}
	if (h >= min+30 && h < min+40) {
		[self setHeight:[NSNumber numberWithInt:startHeight+(4*spacer)]];
		[self setName:[NSString stringWithFormat:@"B"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"green" type:type]];
		[self setNoteImage:image];	
		[self setNoteNum:3];
		[self setColor:[UIColor greenColor]];
	}
	if (h >= min+40 && h < min+50) {
		[self setHeight:[NSNumber numberWithInt:startHeight+(5*spacer)]];
		[self setName:[NSString stringWithFormat:@"A"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"cyan" type:type]];
		[self setNoteImage:image];	
		[self setNoteNum:4];
		[self setColor:[UIColor cyanColor]];
	}
	if (h >= min+50 && h < min+60) {
		[self setHeight:[NSNumber numberWithInt:startHeight+(6*spacer)]];
		[self setName:[NSString stringWithFormat:@"G"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"purple" type:type]];
		[self setNoteImage:image];	
		[self setNoteNum:5];
		[self setColor:[UIColor purpleColor]];
	}
	if (h >= min+60  && h < 120) {
		[self setHeight:[NSNumber numberWithInt:startHeight+(7*spacer)]];
		[self setName:[NSString stringWithFormat:@"F"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"brown" type:type]];
		[self setNoteImage:image];	
		[self setNoteNum:6];
		[self setColor:[UIColor brownColor]];
	}
	//keep track of starting point (where user dropped note so that we can animate movement later
	[self setStartingPoint:CGPointMake(x, h-23)];
	
	NSLog(@"drop height %d", [dropHeight intValue]);
	[self setNeedsDisplay];
}

-(NSString*)noteNameWithColor:(NSString*)mycolor type:(NSNumber*)type {
	float t = [type floatValue];
	if (t == 1) {
		return [NSString stringWithFormat:@"%@%@.png", mycolor, @"Whole"];
	}
	if (t == .5) {
		return [NSString stringWithFormat:@"%@%@.png", mycolor, @"H"];
	}
	if (t == .25) {
		return [NSString stringWithFormat:@"%@%@.png", mycolor, @"Q"];
	}
	if (t == .125) {
		return [NSString stringWithFormat:@"%@%@.png", mycolor, @"E"];
	}
	return nil;
}


@end
