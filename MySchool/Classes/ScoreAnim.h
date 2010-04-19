//
//  ScoreAnim.h
//  MySchool
//
//  Created by Connor Riley on 4/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScoreAnim : UIView {
	UILabel *scoreLabel;
	NSNumber * xValue;
	NSNumber * yValue;
	NSString *scoreValue;
}
@property (nonatomic, retain) UILabel *scoreLabel;
@property (nonatomic, retain) NSNumber *xValue;
@property (nonatomic, retain) NSNumber *yValue;
@property (nonatomic, retain) NSString *scoreValue;
-(id)initWithData:(NSString*)labelvalue x:(NSNumber*)xval y:(NSNumber*)yval;
-(void)drawLabel;
-(id) showApproval:(NSNumber*)value;

@end
