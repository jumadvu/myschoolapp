//
//  baseViewController.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface baseViewController : UIViewController {
	IBOutlet UIButton *mainMenuButton;

}

@property (nonatomic, retain) UIButton *mainMenuButton;

-(IBAction)toMainMenu;

@end
