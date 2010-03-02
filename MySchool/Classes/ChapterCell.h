//
//  ChapterCell.h
//  MySchool
//
//  Created by Connor Riley on 2/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Article;

@interface ChapterCell : UITableViewCell {
	NSString *fileName;
	UILabel *lblTitle;
	UIButton *tButton;
	UIButton *lButton;
	Article *article;
}

@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) UILabel *lblTitle;
@property (nonatomic, retain) UIButton *tButton;
@property (nonatomic, retain) UIButton *lButton;
@property (nonatomic, retain) Article *article;

-(void)teachButtonSelected:(id)sender;
-(void)learnButtonSelected:(id)sender;

@end