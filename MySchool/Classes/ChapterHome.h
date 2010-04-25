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
	IBOutlet UIButton *teachButton;
	IBOutlet UILabel *chapterNameLabel;
	IBOutlet UILabel *numLabel;
	NSString *chapterName;
	IBOutlet UIScrollView *scrollView;
	UIButton *currentButton;
	NSArray *imageArray;
	Chapter *chapter;

}

@property (nonatomic,retain) UIButton *teachButton;
@property (nonatomic,retain) UIButton *currentButton;
@property (nonatomic,retain) UILabel *chapterNameLabel;
@property (nonatomic,retain) UILabel *numLabel;
@property (nonatomic, retain) NSString *chapterName;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSArray *imageArray;
@property (nonatomic, retain) Chapter *chapter;

-(void)loadTextIntoScrollView;
-(void)arrangeImageArray;
-(void)pulseInOut:(NSTimer *)timer;


@end
