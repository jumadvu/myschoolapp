//
//  ChapterHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Chapter;
@class Article;

@interface ChapterHome : baseViewController {
	IBOutlet UIButton *learnButton;
	IBOutlet UILabel *chapterNameLabel;
	IBOutlet UILabel *numLabel;
	NSString *chapterName;
	NSString *fileName;
	Article *article;
	IBOutlet UIScrollView *scrollView;
	UIButton *currentButton;
	NSArray *imageArray;

}

@property (nonatomic,retain) UIButton *learnButton;
@property (nonatomic,retain) UIButton *currentButton;
@property (nonatomic,retain) UILabel *chapterNameLabel;
@property (nonatomic,retain) UILabel *numLabel;
@property (nonatomic, retain) NSString *chapterName;
@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) Article *article;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSArray *imageArray;

-(IBAction)toArticle;
-(void)loadTextIntoScrollView;
-(void)arrangeImageArray;


@end
