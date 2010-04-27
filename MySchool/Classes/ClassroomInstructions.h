//
//  ClassroomInstructions.h
//  MySchool
//
//  Created by Ashley Kayler on 4/26/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ClassroomInstructions : baseViewController {
	UIButton *continueButton;
}

@property (nonatomic, retain) UIButton *continueButton;

-(IBAction)continueToLecture;

@end
