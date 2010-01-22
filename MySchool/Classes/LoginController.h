//
//  LoginController.h
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright DataJedi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController {
	IBOutlet UIButton *goNextButton;
	NSMutableArray *users;
	IBOutlet UIButton *imageButton;
}

@property (nonatomic, retain) UIButton *goNextButton;
@property (nonatomic, retain) UIButton *imageButton;

-(IBAction) gotoNextPage;
-(IBAction) toMainMenu;

@end

