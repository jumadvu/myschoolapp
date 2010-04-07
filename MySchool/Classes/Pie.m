//
//  Pie.m
//  MySchool
//
//  Created by Ashley Kayler on 4/6/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import "Pie.h"
#include <math.h>
#import "MusicNote.h"
#import "Measure.h"

@implementation Pie

@synthesize pieImage;
@synthesize piePieces;
@synthesize myMeasure;

- (void)dealloc {
	[myMeasure release];
	[pieImage release];
	[piePieces release];
    [super dealloc];
}

- (id)init {
	UIImage *image = [UIImage imageNamed:@"pie.png"];
	CGRect frame = CGRectMake(0, 0, image.size.width, image.size.height);
	
	// Set self's frame to encompass the image
	if (self = [self initWithFrame:frame]) {
		self.opaque = NO;
		self.pieImage = image;
		NSMutableArray *anArray = [[NSMutableArray alloc] init];
		[self setPiePieces:anArray];
		[anArray release];		
	}
	[self setNeedsDisplay];	
	return self;
	
}
/*
-(void)drawOnePiePieceWithX:(int)x Y:(int)y radius:(int)radius angle:(float)angle color:(UIColor*)myFillColor {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[myFillColor setFill];
	[[UIColor blackColor] setStroke];
	
	//draw rectangle
	CGContextBeginPath(context);
	CGPoint thePoint = CGPointMake(x, y);
	CGPoint thePoint2 = CGPointMake(x+radius, y);
	CGPoint thePoint3 = CGPointMake(x+radius, y+radius);
	CGPoint thePoint4 = CGPointMake(x, y+radius);
	CGContextMoveToPoint(context, thePoint.x, thePoint.y);
	CGContextAddArcToPoint(context, thePoint2.x, thePoint2.y, thePoint3.x, thePoint3.y, radius);
	CGContextAddLineToPoint(context, thePoint4.x, thePoint4.y);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);
}
*/

-(void)drawOnePiePieceWithX:(int)x Y:(int)y radius:(int)radius angle:(int)angle color:(UIColor*)myFillColor {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[myFillColor setFill];
	[[UIColor blackColor] setStroke];
	
	float startAngle, endAngle;
	switch (angle) {
		case 0:
			startAngle = M_PI/2;
			endAngle = M_PI/4;
			break;
		case 1:
			startAngle = M_PI/4;
			endAngle = 0;
			break;
		case 2:
			startAngle = 0;
			endAngle = 7*M_PI/4;
			break;
		case 3:
			startAngle = 7*M_PI/4;
			endAngle = 3*M_PI/2;
			break;
		case 4:
			startAngle = 3*M_PI/2;
			endAngle = 5*M_PI/4;
			break;
		case 5:
			startAngle = 5*M_PI/4;
			endAngle = M_PI;
			break;
		case 6:
			startAngle = M_PI;
			endAngle = 3*M_PI/4;
			break;
		case 7:
			startAngle = 3*M_PI/4;
			endAngle = M_PI/2;
			break;
		default:
			break;
	}

	//NSLog(@"drawing pie piece at start angle %f end angle %f", startAngle, endAngle);
	//draw rectangle
	CGContextBeginPath(context);
	CGPoint centerPoint = CGPointMake(x, y);
	//CGPoint thePoint1 = CGPointMake(x, y-radius);
	//CGPoint thePoint2 = CGPointMake(x+radius, y+radius);
	//CGPoint thePoint3 = CGPointMake(x, y+radius);
	CGContextMoveToPoint(context, centerPoint.x, centerPoint.y);
	//CGContextAddLineToPoint(context, thePoint1.x, thePoint1.y);
	CGContextAddArc(context, centerPoint.x, centerPoint.y, radius, startAngle, endAngle, 1);
	//CGContextAddLineToPoint(context, centerPoint.x, centerPoint.y);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);
}

-(void)drawPiePiecesWithMeasure:(Measure*)measure {
	[self setMyMeasure:measure];
	//call the draw rect selector
	[self setNeedsDisplay];
	
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
	NSLog(@"drawing pie view");
	if (myMeasure != nil) {
		MusicNote *aNote;
		int x = 0;
		for (aNote in self.myMeasure.measureNotes) {
			NSNumber *numPieces = [NSNumber numberWithFloat:[aNote.fraction floatValue]*8];
			int z = [numPieces intValue];
			NSLog(@"z value:%d", z);
			for (int y=0; y<z; y++) {
				NSLog(@"trying to draw a pie piece at angle: %d", x);
				[self drawOnePiePieceWithX:25 Y:25 radius:25 angle:x color:aNote.color];
				x++;
			}
		}
		
	}

	
}




@end
