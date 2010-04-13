//
//  day_in_history.h
//  MySchool
//
//  Created by Connor Riley on 4/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DayinHistory : baseViewController {
	IBOutlet UILabel *month;
	IBOutlet UITextView *entry;
	IBOutlet UIButton *dateBack;
	IBOutlet UIButton *dateForward;
	NSString *parsedDate;
	NSDate *current;
}
@property (nonatomic, retain) UILabel *month;
@property (nonatomic, retain) UITextView *entry;
@property (nonatomic, retain) UIButton *dateBack;
@property (nonatomic, retain) UIButton *dateForward;
@property (nonatomic, retain) NSDate *current;
@property (nonatomic, retain) NSString *parsedDate;

-(IBAction)backOneDay;
-(IBAction)forwardOneDay;
-(void)changeDate:(NSNumber *)offset;
-(void)loadCurrentEvents;

@end
