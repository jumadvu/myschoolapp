//
//  MainMenu.h
//  MySchool
//
//  Created by Ashley Kayler on 1/21/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainMenu : UIViewController {
	IBOutlet UITabBarController *tabBarController;

}

@property (nonatomic, retain) UITabBarController *tabBarController;

@end
