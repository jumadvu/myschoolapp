//
//  Measure.h
//  MySchool
//
//  Created by Ashley Kayler on 3/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicNote;

@interface Measure : UIView {
	UIImage *measureImage;
	NSMutableArray *measureNotes;
	NSString *mathString;
	NSNumber *nextSpace;
	int measureLength;
}

@property (nonatomic, retain) UIImage *measureImage;
@property (nonatomic, retain) NSMutableArray *measureNotes;
@property (nonatomic, retain) NSString *mathString;
@property (nonatomic, retain) NSNumber *nextSpace;
@property (nonatomic) int measureLength;

-(NSNumber*)currentSum;
-(void)tryToAddNote:(MusicNote*)note;
-(BOOL)isFull;
-(NSString*)currentSumText:(NSNumber *)num;
- (void)drawRectangleWithX:(int)x Y:(int)y width:(int)width height:(float)height color:(UIColor*)myFillColor;

@end
