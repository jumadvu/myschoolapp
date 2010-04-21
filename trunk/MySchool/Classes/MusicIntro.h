//
//  MusicIntro.h
//  MySchool
//
//  Created by Ashley Kayler on 3/23/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MusicFreestyle;

@interface MusicIntro : baseViewController {
	NSString *level;
	IBOutlet UILabel *heading;
	IBOutlet UITextView *instructions;
	IBOutlet UIImageView *imageView;
	int pageNum;
	IBOutlet UIButton *continueButton;
	IBOutlet UIButton *prevButton;
	IBOutlet UIButton *skipToGameButton;
}

@property (nonatomic, retain) NSString *level;
@property (nonatomic, retain) UITextView *instructions;
@property (nonatomic, retain) UILabel *heading;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic) int pageNum;
@property (nonatomic, retain) UIButton *continueButton;
@property (nonatomic, retain) UIButton *prevButton;
@property (nonatomic, retain) UIButton *skipToGameButton;

-(IBAction) goNext;
-(IBAction) goPrevious;
-(IBAction) toGame;

-(void)showPage1;
-(void)showPage2;
-(void)showPage3;
-(void)showPage4;
- (void)loadGame;
- (void)startGame:(MusicFreestyle*)vc;

@end
