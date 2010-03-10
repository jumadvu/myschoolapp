//
//  LoungeHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoungeHome : baseViewController {
	IBOutlet UIButton *gradeButton;
	IBOutlet UILabel *numPapersLabel;

}

@property (nonatomic, retain) UIButton *gradeButton;
@property (nonatomic, retain) UILabel *numPapersLabel;

-(IBAction)toPapersToGrade;

@end
