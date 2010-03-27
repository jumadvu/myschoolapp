//
//  Measure.m
//  MySchool
//
//  Created by Ashley Kayler on 3/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "Measure.h"
#import "MusicNote.h"

@implementation Measure

@synthesize measureNotes;
@synthesize measureImage;
@synthesize mathString;
@synthesize nextSpace;
@synthesize measureLength;

- (void)dealloc {
	[nextSpace release];
	[mathString release];
	[measureNotes release];
	[measureImage release];
    [super dealloc];
}


- (id)init {
	UIImage *image = [UIImage imageNamed:@"measure.png"];
	CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
	
	// Set self's frame to encompass the image
	if (self = [self initWithFrame:frame]) {
		self.measureLength = 320;
		self.opaque = NO;
		self.measureImage = image;
		NSMutableArray *anArray = [[NSMutableArray alloc] init];
		[self setMeasureNotes:anArray];
		[anArray release];
		NSLog(@"how many notes in this measure: %d", [measureNotes count]);
		[self setNextSpace:[NSNumber numberWithInt:45]];
		
	}
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

-(void)tryToAddNote:(MusicNote*)note {
	float newSum = [[self currentSum] floatValue] + [note.fraction floatValue];
	if (newSum <= 1) {
		//add the note to the measure
		[measureNotes addObject:note];
		[self addSubview:note];
		note.center = CGPointMake([nextSpace intValue], [note.height intValue]);
		int spacer = [nextSpace intValue] + measureLength * [note.fraction floatValue];
		[self setNextSpace:[NSNumber numberWithInt:spacer]];
	}
	if (newSum == 1) {
		//measure is full. flash green and move on to next measure
		[self setNeedsDisplay];
		
	}
	if (newSum > 1) {
		//can't fit this note. show feedback. vibrate
	}
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
		[self drawRectangleWithX:0 Y:15 width:350 height:80 color:[UIColor greenColor]];
	}
}




@end
