//
//  GradePaperCell.h
//  MySchool
//
//  Created by Ashley on 2/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradePaperCell : UITableViewCell {
	UILabel *lblQuestion;
	UILabel *lblAnswer;
	UIButton *correctButton;
	UIButton *wrongButton;
	id delegate;
}

@property (nonatomic, retain) UILabel *lblQuestion;
@property (nonatomic, retain) UILabel *lblAnswer;
@property (nonatomic, retain) UIButton *correctButton;
@property (nonatomic, retain) UIButton *wrongButton;
@property (assign) id delegate;

-(void)correctButtonSelected:(id)sender;
-(void)wrongButtonSelected:(id)sender;
-(void)setQuestion:(NSString*)qText andAnswer:(NSString*)aText qHeight:(NSNumber*)qHeight aHeight:(NSNumber*)aHeight;

@end