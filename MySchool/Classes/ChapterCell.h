//
//  ChapterCell.h
//  MySchool
//
//  Created by Connor Riley on 2/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Article;
@class Chapter;

@interface ChapterCell : UITableViewCell {
	NSString *fileName;
	UILabel *lblTitle;
	UIButton *tButton;
	UIButton *lButton;
	Article *article;
	Chapter *chapter;
}

@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) UILabel *lblTitle;
@property (nonatomic, retain) UIButton *tButton;
@property (nonatomic, retain) UIButton *lButton;
@property (nonatomic, retain) Article *article;
@property (nonatomic, retain) Chapter *chapter;

-(void)teachButtonSelected:(id)sender;
-(void)learnButtonSelected:(id)sender;

@end