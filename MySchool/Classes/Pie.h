//
//  Pie.h
//  MySchool
//
//  Created by Ashley Kayler on 4/6/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Measure;

@interface Pie : UIView {
	UIImage *pieImage;
	NSMutableArray *piePieces;
	Measure *myMeasure;
}

@property (nonatomic, retain) UIImage *pieImage;
@property (nonatomic, retain) NSMutableArray *piePieces;
@property (nonatomic, retain) Measure *myMeasure;

-(void)drawOnePiePieceWithX:(int)x Y:(int)y radius:(int)radius angle:(int)angle color:(UIColor*)myFillColor;
-(void)drawPiePiecesWithMeasure:(Measure*)measure;

@end
