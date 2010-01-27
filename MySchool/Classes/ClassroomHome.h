//
//  ClassroomHome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ClassroomHome : baseViewController {
	IBOutlet UIButton *chalkboardButton;
	IBOutlet UIButton *questionButton;
	IBOutlet UIButton *worksheetsButton;

}

@property (nonatomic, retain) UIButton *chalkboardButton;
@property (nonatomic, retain) UIButton *questionButton;
@property (nonatomic, retain) UIButton *worksheetsButton;

-(IBAction)toChalkboard;
-(IBAction)toQuestion;
-(IBAction)toWorksheets;

@end
