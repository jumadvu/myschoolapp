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
	UILabel *lblTitle;
	Article *article;
	Chapter *chapter;
}

@property (nonatomic, retain) UILabel *lblTitle;
@property (nonatomic, retain) Article *article;
@property (nonatomic, retain) Chapter *chapter;

@end