//
//  PrincipalHelp.h
//  MySchool
//
//  Created by ashleyk on 7/5/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PrincipalHelp : baseViewController {

	IBOutlet UITextView *textLbl;
	IBOutlet UIImageView *imageView;
	NSArray *helpitems;
	NSNumber *helpNum;
	IBOutlet UIButton *continueButton;
	
}
@property (nonatomic, retain) UIButton *continueButton;
@property (nonatomic, retain) NSArray *helpitems;
@property (nonatomic, retain) NSNumber *helpNum;

@property (nonatomic, retain) UITextView *textLbl;
@property (nonatomic, retain) UIImageView *imageView;

-(IBAction) continueButtonClicked;

@end
