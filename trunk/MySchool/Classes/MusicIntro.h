//
//  MusicIntro.h
//  MySchool
//
//  Created by Ashley Kayler on 3/23/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MusicIntro : baseViewController {
	NSString *level;
	IBOutlet UILabel *heading;
	IBOutlet UITextView *instructions;
}

@property (nonatomic, retain) NSString *level;
@property (nonatomic, retain) UITextView *instructions;
@property (nonatomic, retain) UILabel *heading;

-(IBAction) continueOn;

@end
