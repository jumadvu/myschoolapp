//
//  Color.h
//  MySchool
//
//  Created by Connor Riley on 4/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Color : baseViewController {
	IBOutlet UIButton *redButton;
	IBOutlet UIButton *greenButton;
	IBOutlet UIButton *blueButton;
	IBOutlet UILabel *level;
	IBOutlet UILabel *points;
	IBOutlet UIView *targetColor;
	IBOutlet UIView *currentColor;
	int redValue;
	int greenValue;
	int blueValue;
	int pointVal;
	int levVal;
	int tRed;
	int tBlue;
	int tGreen;
	bool isLight;
}
@property (nonatomic, retain) UIButton *redButton;
@property (nonatomic, retain) UIButton *greenButton;
@property (nonatomic, retain) UIButton *blueButton;
@property (nonatomic, retain) UILabel *level;
@property (nonatomic, retain) UILabel *points;
@property (nonatomic, retain) UIView *targetColor;
@property (nonatomic, retain) UIView *currentColor;
@property (nonatomic) int redValue;
@property (nonatomic) int greenValue;
@property (nonatomic) int blueValue;
@property (nonatomic) int pointVal;
@property (nonatomic) int levVal;
@property (nonatomic) int tRed;
@property (nonatomic) int tBlue;
@property (nonatomic) int tGreen;
@property (nonatomic) bool isLight;

-(IBAction)incRed;
-(IBAction)incBlue;
-(IBAction)incGreen;
-(IBAction)makeColor;
-(void)newTarget;

@end
