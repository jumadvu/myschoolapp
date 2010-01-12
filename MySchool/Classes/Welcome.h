//
//  Welcome.h
//  MySchool
//
//  Created by Ashley Kayler on 1/11/10.
//  Copyright 2010 DataJedi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Welcome : UIViewController {
	UIButton *backButton;
}

@property (nonatomic, retain) UIButton *backButton;

-(IBAction)gotoFirstPage;

@end
