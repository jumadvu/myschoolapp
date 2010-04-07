//
//  MusicNote.h
//  MySchool
//
//  Created by Ashley Kayler on 3/25/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MusicNote : UIView {
	UIImage *noteImage;
	UILabel *myString;
	CGPoint startingPoint;
	NSNumber *fraction;
	NSNumber *height;
	NSString *name;
	NSString *fractionString;
	int noteNum;
	UIColor *color;
	
}

@property (nonatomic, retain) UIImage *noteImage;
@property (nonatomic, retain) UILabel *myString;
@property (nonatomic) CGPoint startingPoint;
@property (nonatomic, retain) NSNumber *fraction;
@property (nonatomic, retain) NSNumber *height;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *fractionString;
@property (nonatomic) int noteNum;
@property (nonatomic, retain) UIColor *color;

-(void)setNoteType:(NSNumber*)type atHeight:(NSNumber*)dropHeight;
-(void)setFractionStringText:(NSNumber *)num;
-(NSString*)noteNameWithColor:(NSString*)mycolor type:(NSNumber*)type;

@end
