//
//  MySchoolViewController.h
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright DataJedi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController {
	IBOutlet UIButton *goNextButton;
}

@property (nonatomic, retain) UIButton *goNextButton;

-(IBAction) gotoNextPage;

@end

