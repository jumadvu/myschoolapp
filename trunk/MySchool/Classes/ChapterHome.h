//
//  ChapterHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChapterHome : baseViewController {
	IBOutlet UIButton *learnButton;
	IBOutlet UILabel *chapterNameLabel;
	IBOutlet UITextView *textView;
	NSString *chapterName;
	NSString *fileName;

}

@property (nonatomic,retain) UIButton *learnButton;
@property (nonatomic,retain) UILabel *chapterNameLabel;
@property (nonatomic, retain) NSString *chapterName;
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) NSString *fileName;

-(IBAction)toArticle;

@end