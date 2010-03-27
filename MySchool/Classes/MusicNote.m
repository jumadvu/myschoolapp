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
@synthesize fraction;
@synthesize height;
@synthesize name;
@synthesize fractionString;

- (void)dealloc {
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


-(void)setNoteType:(NSNumber*)type atHeight:(NSNumber*)dropHeight {
	[self setFraction:type];
	[self setFractionStringText:type];
	int h = [dropHeight intValue];
	if (h == 1000) {
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"black" type:type]];
		[self setNoteImage:image];	
	}
	if (h >= -4 && h < 6) {
		[self setHeight:[NSNumber numberWithInt:1]];
		[self setName:[NSString stringWithFormat:@"A"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"red" type:type]];
		[self setNoteImage:image];	
	}
	if (h >= 6 && h < 16) {
		[self setHeight:[NSNumber numberWithInt:11]];
		[self setName:[NSString stringWithFormat:@"B"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"orange" type:type]];
		[self setNoteImage:image];	
	}
	if (h >= 16 && h < 26) {
		[self setHeight:[NSNumber numberWithInt:21]];
		[self setName:[NSString stringWithFormat:@"C"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"yellow" type:type]];
		[self setNoteImage:image];	
	}
	if (h >= 26 && h < 36) {
		[self setHeight:[NSNumber numberWithInt:31]];
		[self setName:[NSString stringWithFormat:@"D"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"green" type:type]];
		[self setNoteImage:image];	
	}
	if (h >= 36 && h < 46) {
		[self setHeight:[NSNumber numberWithInt:41]];
		[self setName:[NSString stringWithFormat:@"E"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"cyan" type:type]];
		[self setNoteImage:image];	
	}
	if (h >= 46 && h < 56) {
		[self setHeight:[NSNumber numberWithInt:51]];
		[self setName:[NSString stringWithFormat:@"F"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"purple" type:type]];
		[self setNoteImage:image];	
	}
	if (h >= 56 && h < 68) {
		[self setHeight:[NSNumber numberWithInt:61]];
		[self setName:[NSString stringWithFormat:@"G"]];
		UIImage *image = [UIImage imageNamed:[self noteNameWithColor:@"brown" type:type]];
		[self setNoteImage:image];	
	}
	NSLog(@"drop height %d", [dropHeight intValue]);
}

-(NSString*)noteNameWithColor:(NSString*)color type:(NSNumber*)type {
	float t = [type floatValue];
	if (t == 1) {
		return [NSString stringWithFormat:@"%@%@.png", color, @"Whole"];
	}
	if (t == .5) {
		return [NSString stringWithFormat:@"%@%@.png", color, @"H"];
	}
	if (t == .25) {
		return [NSString stringWithFormat:@"%@%@.png", color, @"Q"];
	}
	if (t == .125) {
		return [NSString stringWithFormat:@"%@%@.png", color, @"E"];
	}
	return nil;
}


@end
